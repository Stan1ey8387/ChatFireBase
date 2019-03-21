//
//  AuthorizationViewModel.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 29/11/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

final class AuthorizationViewModel: AuthorizationViewModelInput, Routable {
    weak var view: AuthorizationViewModelOutput?
    var router: AuthorizationRouter?
    
    enum Routes {
        case mainTabBar
    }
    
    func registration(name: String?, email: String?, password: String?, photo: Data?) throws {
        guard let name = name, !name.isEmpty else { throw AuthError.incorrectName }
        guard let email = email, !email.isEmpty else { throw AuthError.incorrectEmail }
        guard let password = password, !password.isEmpty else { throw AuthError.incorrectPassword }
        
        if let photoData = photo {
            let ref = Storage.storage().reference().child("UsersPhoto").child("\(UUID().uuidString).jpeg")
            let metadata = StorageMetadata()
            metadata.contentType = ".jpeg"
            
            ref.putData(photoData, metadata: nil) { [weak self] (metadata, error) in //тут
                guard error == nil else {
                    self?.view?.showError(message: error?.localizedDescription ?? "")
                    return}
                
                ref.downloadURL(completion: { [weak self] (url, error) in
                    self?.registrarion(name: name, email: email, password: password, photoLink: url?.absoluteString)
                })
            }
        } else {
            registrarion(name: name, email: email, password: password)
        }
    }
    
    func auth(email: String?, password: String?) throws {
        guard let email = email, !email.isEmpty else { throw AuthError.incorrectEmail }
        guard let password = password, !password.isEmpty else { throw AuthError.incorrectPassword }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            guard error == nil else { self?.view?.showError(message: error?.localizedDescription ?? ""); return}
            
            self?.router?.route(to: .mainTabBar)
        }
    }
    
    fileprivate func registrarion(name: String, email: String, password: String, photoLink: String? = nil) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
            guard error == nil, let userUID = result?.user.uid else { self?.view?.showError(message: error?.localizedDescription ?? ""); return}
            
            let ref = Database.database().reference(fromURL: "https://chat-efbaf.firebaseio.com/").child("Users").child(userUID)
            var values = ["name": name, "email": email]
            
            if let photoLink = photoLink {
                values.updateValue(photoLink, forKey: "photo")
            }
            
            ref.updateChildValues(values, withCompletionBlock: { [weak self] (error, _) in
                guard error == nil else { self?.view?.showError(message: error?.localizedDescription ?? ""); return}
                
                self?.router?.route(to: .mainTabBar)
            })
        }
    }
}
