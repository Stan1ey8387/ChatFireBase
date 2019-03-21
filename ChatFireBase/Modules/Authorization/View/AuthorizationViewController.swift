//
//  AuthorizationViewController.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 28/11/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit

final class AuthorizationViewController: UIViewController  {
    public var viewModel: AuthorizationViewModelInput?
    
    fileprivate let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.image = UIImage(named: "UserPlaceholder")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        
        return imageView
    }()
    
    fileprivate let containerView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = #colorLiteral(red: 0.4094915986, green: 0.7693701386, blue: 0.9626758695, alpha: 0.7224911972)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    fileprivate let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    fileprivate let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your name"
        textField.autocapitalizationType = .words
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isHidden = true
        
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        return textField
    }()
    
    fileprivate let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your email"
        textField.text = "email@email.ru"
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        return textField
    }()
    
    fileprivate let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your password"
        textField.text = "123456"
        textField.isSecureTextEntry = true
        textField.returnKeyType = .go
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        return textField
    }()
    
    fileprivate let loginButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 22
        button.backgroundColor = .black
        button.setTitle("Login", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        return button
    }()
    
    fileprivate let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.lightGray, for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(register), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopIndicator()
    }
    
    deinit {
        print("AuthorizationViewController deinit")
    }
    
    fileprivate func setupView() {
        view.backgroundColor = .white
        
        setupContainerView()
        setupPhotoImageView()
        setupContainerStackView()
        
        setupLoginButton()
        setupRegisterButton()
    }
    
    fileprivate func setupContainerView() {
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.75),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(lessThanOrEqualTo: view.centerYAnchor, constant: -50),
            ])
    }
    
    fileprivate func setupPhotoImageView() {
        view.addSubview(photoImageView)
        
        NSLayoutConstraint.activate([
            photoImageView.heightAnchor.constraint(equalToConstant: 80),
            photoImageView.widthAnchor.constraint(equalToConstant: 80),
            photoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoImageView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.topAnchor, constant: -50),
            ])
        
        photoImageView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showImagePickerAlert))
        photoImageView.addGestureRecognizer(tap)
    }
    
    fileprivate func setupContainerStackView() {
        containerView.addSubview(containerStackView)
        
        NSLayoutConstraint.activate([
            containerStackView.leftAnchor.constraint(lessThanOrEqualTo: containerView.leftAnchor, constant: 30),
            containerStackView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            containerStackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            ])
        
        containerStackView.addArrangedSubview(nameTextField)
        containerStackView.addArrangedSubview(emailTextField)
        containerStackView.addArrangedSubview(passwordTextField)
        
        nameTextField.setBottomBorder()
        emailTextField.setBottomBorder()
    }
    
    fileprivate func setupLoginButton() {
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 44),
            loginButton.widthAnchor.constraint(equalToConstant: view.bounds.width/2),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -100),
        ])
    }
    
    fileprivate func setupRegisterButton() {
        view.addSubview(registerButton)
        
        NSLayoutConstraint.activate([
            registerButton.heightAnchor.constraint(equalToConstant: 20),
            registerButton.widthAnchor.constraint(equalToConstant: view.bounds.width/2),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.topAnchor.constraint(lessThanOrEqualTo: loginButton.bottomAnchor, constant: 20),
            ])
    }
    
    // MARK: Methods
    
    fileprivate func showImagePicker(type: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = type
        imagePicker.allowsEditing = true
        
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    
    // MARK: Selectors
    
    @objc fileprivate func showImagePickerAlert() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] (_) in
            self?.showImagePicker(type: .camera)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default) { [weak self] (_) in
            self?.showImagePicker(type: .photoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc fileprivate func login() {
        if !nameTextField.isHidden && !(photoImageView.alpha == 0) {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.nameTextField.isHidden = true
                self?.photoImageView.alpha = 0
            }
            
            return
        }
        
        do {
            startIndicator()
            try viewModel?.auth(email: emailTextField.text,
                                password: passwordTextField.text)
        } catch {
            stopIndicator()
            showAlert("Warning", message: (error as? AuthError)?.description, titleAction: "OK", cancelAction: false)
        }
    }
    
    @objc fileprivate func register() {
        if nameTextField.isHidden && (photoImageView.alpha == 0) {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.nameTextField.isHidden = false
                self?.photoImageView.alpha = 1
            }
            
            return
        }
        
        do {
            startIndicator()
            
            var photoData: Data? {
                if photoImageView.image != UIImage(named: "UserPlaceholder") {
                    return photoImageView.image?.jpegData(compressionQuality: 1)
                } else {
                    return nil
                }
            }
            
            try viewModel?.registration(name: nameTextField.text,
                                        email: emailTextField.text,
                                        password: passwordTextField.text,
                                        photo: photoData)
        } catch {
            stopIndicator()
            showAlert("Warning", message: (error as? AuthError)?.description, titleAction: "OK", cancelAction: false)
        }
    }
}


extension AuthorizationViewController: AuthorizationViewModelOutput {
    func showError(message: String) {
        stopIndicator()
        showAlert("Error", message: message, titleAction: "OK", cancelAction: false)
    }
}


extension AuthorizationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        
        if textField == passwordTextField {
            nameTextField.isHidden ? login() : register()
        }
        
        return true
    }
}


extension AuthorizationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.editedImage] as? UIImage else {
            showError(message: "No image selected")
            return }
        photoImageView.image = image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
