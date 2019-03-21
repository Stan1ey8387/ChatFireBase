//
//  ChatChatViewController.swift
//  project
//
//  Created by Zakhar Babkin on 02/12/2018.
//  Copyright © 2018 Zachary Babkin. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation

final class ChatViewController: UIViewController {
    public var viewModel: ChatViewModelInput?
    
    fileprivate var messages = [Message]()
    
    fileprivate let rightBarContainerView: UIView = {
        let containView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        return containView
    }()
    
    fileprivate let rightBarImageView: UIImageView = {
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageview.image = UIImage(named: "UserPlaceholder")
        imageview.contentMode = .scaleAspectFill
        imageview.roundRadius()
        
        return imageview
    }()
    
    fileprivate let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ChatBackground")
        
        return imageView
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.contentInset.bottom = 10
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: "TextMessageCell")
        tableView.register(MessageImageTableViewCell.self, forCellReuseIdentifier: "ImageMessageCell")
        tableView.register(MessageVideoTableViewCell.self, forCellReuseIdentifier: "VideoMessageCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    fileprivate let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9764990211, green: 0.976420939, blue: 0.9806668162, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    fileprivate let separationView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    fileprivate let addImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(showImagePickerAlert), for: .touchUpInside)
        
        return button
    }()
    
    fileprivate let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter message text"
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    fileprivate let sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupKeyboardObserver()
        
        //startIndicator()
        viewModel?.fetchMessage()
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("ChatViewController deinit")
    }
    
    fileprivate func setupViews() {
        view.backgroundColor = .white
        navigationItem.title = viewModel?.user.name
        
        if let userPhoto = viewModel?.user.photo {
            rightBarImageView.setImage(url: URL(string: userPhoto))
        }
        
        rightBarContainerView.addSubview(rightBarImageView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarContainerView)
    
        setupContainerView()
        setupSeparationView()
        setupSendButton()
        setupInputTextField()
        
        
        setupAddImageButton()
        setupTableView()
    }
    
    fileprivate func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerView.topAnchor),
            ])
        
        tableView.backgroundView = backgroundImageView
    }
    
    fileprivate func setupContainerView() {
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 50),
            ])
    }
    
    fileprivate func setupSeparationView() {
        containerView.addSubview(separationView)
        
        NSLayoutConstraint.activate([
            separationView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            separationView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            separationView.heightAnchor.constraint(equalToConstant: 1),
            separationView.topAnchor.constraint(equalTo: containerView.topAnchor),
            ])
    }
    
    fileprivate func setupSendButton() {
        containerView.addSubview(sendButton)
        
        NSLayoutConstraint.activate([
            sendButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            sendButton.heightAnchor.constraint(equalToConstant: 50),
            sendButton.widthAnchor.constraint(equalToConstant: 50),
            sendButton.topAnchor.constraint(equalTo: containerView.topAnchor)
            ])
    }
    
    
    func setupAddImageButton() {
        containerView.addSubview(addImageButton)
        
        NSLayoutConstraint.activate([
            addImageButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            addImageButton.widthAnchor.constraint(equalToConstant: 40),
            addImageButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            addImageButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            ])
    }
    
    fileprivate func setupInputTextField() {
        containerView.addSubview(inputTextField)
        
        NSLayoutConstraint.activate([
            inputTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 60),
            inputTextField.trailingAnchor.constraint(equalTo: sendButton.trailingAnchor, constant: -60),
            inputTextField.topAnchor.constraint(equalTo: containerView.topAnchor),
            inputTextField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            ])
        
        inputTextField.delegate = self
    }
    
    // Methods
    
    fileprivate func setupKeyboardObserver() {
        KeyboardObserver.willShow { [weak self] (keyboardHeight) in
            self?.tableView.contentInset.top = keyboardHeight.height - (self?.view.safeAreaInsets.bottom ?? 0)
            self?.view.frame.origin.y = -(keyboardHeight.height - (self?.view.safeAreaInsets.bottom ?? 0))
        }
        
        KeyboardObserver.willHide { [weak self] (keyboardHeight) in
            self?.tableView.contentInset.top = 0
            self?.view.frame.origin.y = 0
        }
    }
    
    fileprivate func showImagePicker(type: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = type
        imagePicker.mediaTypes =  [kUTTypeImage, kUTTypeMovie] as [String]
        
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    // Selectors
    
    @objc fileprivate func sendMessage() {
        guard let text = inputTextField.text, text != "" else { return }

        viewModel?.sendMessage(text: text)
        inputTextField.text = ""
    }
    
    @objc fileprivate func showImagePickerAlert() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] (_) in
            self?.showImagePicker(type: .camera)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Library", style: .default) { [weak self] (_) in
            self?.showImagePicker(type: .photoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension ChatViewController: ChatViewModelOutput {
    func update(messages: [Message]) {
        self.messages = messages
        tableView.reloadData()
        stopIndicator()
        
        guard !messages.isEmpty else { return }
        let indexPath = IndexPath(row: self.messages.count-1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
    }
    
    func showError(message: String) {
        showAlert("Error", message: message, titleAction: "OK", cancelAction: false)
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        switch message.type {
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextMessageCell", for: indexPath) as? MessageTableViewCell
            cell?.configurate(with: message)
            
            return cell ?? UITableViewCell()
            
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageMessageCell", for: indexPath) as? MessageImageTableViewCell
            cell?.delegate = self
            cell?.configurate(with: message)
            
            return cell ?? UITableViewCell()
        case .video:
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoMessageCell", for: indexPath) as? MessageVideoTableViewCell
            cell?.videoDelegate = self
            cell?.configurate(with: message)
            
            return cell ?? UITableViewCell()
        case .none:
            return UITableViewCell()
        }
    }
}

extension ChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        sendMessage()
        
        return true
    }
}

extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            viewModel?.sendMessage(videoURL: videoURL)
        } else if let image = info[.originalImage] as? UIImage, let imageData = image.jpegData(compressionQuality: 1) {
            viewModel?.sendMessage(photoData: imageData)
        } else {
            showError(message: "No image selected")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ChatViewController: MessageImageTableViewCellDelegate {
    func selected(image: Data) {
        viewModel?.openDetailImage(with: image)
    }
}

extension ChatViewController: MessageVideoTableViewCellDelegate {
    func selected(video: URL, previewImage: Data) {
        viewModel?.openDetailVideo(with: video, previewImage: previewImage)
    }
}
