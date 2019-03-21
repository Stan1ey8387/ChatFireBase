//
//  MessagesMessagesViewModel.swift
//  project
//
//  Created by Zakhar Babkin on 01/12/2018.
//  Copyright © 2018 Zachary Babkin. All rights reserved.
//

import Firebase

final class MessagesViewModel: MessagesViewModelInput, Routable {
    weak var view: MessagesViewModelOutput?
    var router: MessagesRouter?
    
    fileprivate var timer: Timer?
    fileprivate var messagesDictionary = [String: Message]()
    fileprivate var userId: String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    
    enum Routes {
        case chat(user: User)
    }
    
    func fetchMessages() {
        let ref = Database.database().reference().child("UserMessages").child(userId)
        ref.observe(.childAdded, with: { [weak self] (snapshot) in
            let messageRef = Database.database().reference().child("Messages").child(snapshot.key)
            messageRef.observeSingleEvent(of: .value, with: { (snapshot) in
                self?.handler(snapshot: snapshot)
            })
            
        }) { [weak self] (error) in
            self?.view?.showError(message: error.localizedDescription)
        }
    }
    
    func chat(with user: User) {
        router?.route(to: .chat(user: user))
    }
    
    fileprivate func handler(snapshot: DataSnapshot) {
        guard let dictionary = (snapshot.value as? [String: Any]) else { return }
        guard var message = Message(dictionary: dictionary) else { return }
        
        self.getUser(for: message, completion: { [weak self] (user) in
            message.user = user
            if message.toUserId == self?.userId {
                self?.messagesDictionary[message.fromUserId] = message
            } else {
                self?.messagesDictionary[message.toUserId] = message
            }
            
            var messages = Array((self?.messagesDictionary ?? [:]).values)
            messages.sort(by: { (message1, message2) -> Bool in
                //refactoring
                message1.dataCreate.getDate()!.timeIntervalSinceNow > message2.dataCreate.getDate()!.timeIntervalSinceNow
            })
            
            DispatchQueue.main.async {
                self?.timer?.invalidate()
                self?.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
                    self?.view?.update(messages: messages)
                })
            }
        })
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
        }) { [weak self] (error) in
            self?.view?.showError(message: error.localizedDescription)
        }
    }
}
