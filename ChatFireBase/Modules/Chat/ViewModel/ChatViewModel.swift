//
//  ChatChatViewModel.swift
//  project
//
//  Created by Zakhar Babkin on 02/12/2018.
//  Copyright © 2018 Zachary Babkin. All rights reserved.
//

import Firebase
import AVFoundation


final class ChatViewModel: ChatViewModelInput, Routable {
    weak var view: ChatViewModelOutput?
    var router: ChatRouter?
    
    fileprivate var userId: String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    
    fileprivate var timer: Timer?
    
    var user: User
    
    init(user: User) {
        self.user = user
    }

    enum Routes {
        case openDetailImage(Data)
        case openDetailVideo(URL, previewImage: Data)
    }
    
    func fetchMessage() {
        var messages = [Message]()
        
        let userMessagesRef = Database.database().reference().child("UserMessages").child(userId)
        userMessagesRef.observe(.childAdded, with: { [weak self] (snapshot) in
            let messageRef = Database.database().reference().child("Messages").child(snapshot.key)
            messageRef.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let messageDictionary = snapshot.value as? [String: Any] else { return }
                guard var message = Message(dictionary: messageDictionary) else { return }
                
                self?.getUser(for: message, completion: { (user) in
                    message.user = user
                    
                    if message.user?.uid == self?.user.uid {
                        messages.append(message)
                    }
                    
                    DispatchQueue.main.async {
                        self?.timer?.invalidate()
                        self?.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { (_) in
                            self?.view?.update(messages: messages)
                        })
                    }
                })
            })
        }) { (error) in
            print(error)
        }
    }
    
    func sendMessage(text: String) {
        sendMessage(type: .text, text: text)
    }
    
    func sendMessage(photoData: Data) {
        let ref = Storage.storage().reference().child("MessagePhoto").child("\(UUID().uuidString).jpeg")
        
        ref.putData(photoData, metadata: nil) { [weak self] (metadata, error) in
            guard error == nil else {
                self?.view?.showError(message: error?.localizedDescription ?? "")
                return}
            
            ref.downloadURL(completion: { [weak self] (url, error) in
                guard let url = url else { return }
                let imageSize = photoData.getImageSize()
                let image = Image.init(image:  url.absoluteString, width: Float(imageSize.width), height: Float(imageSize.height))
                self?.sendMessage(type: .image, image: image)
            })
        }
    }
    
    func sendMessage(videoURL: URL) {
        let videoRef = Storage.storage().reference().child("MessageVideo").child("\(UUID().uuidString).mov")
        let imageRef = Storage.storage().reference().child("MessagePhoto").child("\(UUID().uuidString).jpeg")
        
        videoRef.putFile(from: videoURL, metadata: nil) { [weak self] (metadata, error) in
            guard error == nil else {
                self?.view?.showError(message: error?.localizedDescription ?? "")
                return}
            
            videoRef.downloadURL(completion: { [weak self] (url, error) in
                guard let videoUrl = url else { return }
                guard let previewImageData = self?.getPreviewImage(url: videoUrl)?.jpegData(compressionQuality: 1) else { return }
                
                imageRef.putData(previewImageData, metadata: nil) { [weak self] (metadata, error) in
                    guard error == nil else {
                        self?.view?.showError(message: error?.localizedDescription ?? "")
                        return}
                    
                    imageRef.downloadURL(completion: { [weak self] (url, error) in
                        guard let imageUrl = url else { return }
                        let imageSize = previewImageData.getImageSize()
                        let image = Image.init(image:  imageUrl.absoluteString, width: Float(imageSize.width), height: Float(imageSize.height))
                            
                        self?.sendMessage(type: .video, image: image, video: videoUrl.absoluteString)
                    })
                }
                
            })
        }
    }
    
    func close() {
        router?.close(animated: false)
    }
    
    func openDetailImage(with image: Data) {
        router?.route(to: .openDetailImage(image))
    }
    
    func openDetailVideo(with video: URL, previewImage: Data) {
        router?.route(to: .openDetailVideo(video, previewImage: previewImage))
    }
    
    fileprivate func sendMessage(type: MessageType, text: String? = nil, image: Image? = nil, video: String? = nil) {
        let ref = Database.database().reference()
        let messageRef = ref.child("Messages").childByAutoId()
        guard let toUserId = user.uid, let fromUserId = Auth.auth().currentUser?.uid else { return }
        let message = Message.init(type: type,
                                   text: text,
                                   image: image,
                                   video: video,
                                   toUserId: toUserId,
                                   fromUserId: fromUserId,
                                   dataCreate: "\(Date())",
                                    user: user)
        
        messageRef.updateChildValues(message.dictionaryData)
        
        let userMessagesRef = ref.child("UserMessages")
        userMessagesRef.child(fromUserId).updateChildValues([messageRef.key ?? "": "messageKey"])
        
        let receptionUserMessagesRef = ref.child("UserMessages")
        receptionUserMessagesRef.child(toUserId).updateChildValues([messageRef.key ?? "": "messageKey"])
    }
    
    fileprivate func getUser(for message: Message, completion: @escaping (User) -> ()) {
        var id: String {
            if message.toUserId == userId {
                return message.fromUserId
            } else {
                return message.toUserId
            }
        }
        
        let ref = Database.database().reference().child("Users").child(id)
        
        ref.observe(.value, with: { (snapshot) in
            guard let userDictinary = snapshot.value as? [String: Any] else { return }
            guard var user = User(dictionary: userDictinary) else { return }
            user.uid = snapshot.ref.key
            
            completion(user)
        }) { (error) in
            print(error)
        }
    }
    
    fileprivate func getPreviewImage(url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 30) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        
        return nil
    }
}

