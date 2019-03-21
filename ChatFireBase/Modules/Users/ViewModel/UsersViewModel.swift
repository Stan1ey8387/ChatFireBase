//
//  UsersViewModel.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 29/11/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import Foundation
import Firebase

class UsersViewModel: UsersViewModelInput, Routable {
    public weak var view: UsersViewModelOutput?
    var router: UsersRouter?
    
    fileprivate var timer: Timer?
    
    enum Routes {
        case chat(user: User)
    }
    
    func fetchUsers() {
        var users = [User]()
        
        Database.database().reference().child("Users").observe(.childAdded, with: { [weak self] (snapshot) in
                guard let userDictinary = snapshot.value as? [String: Any] else { return }
                guard var user = User(dictionary: userDictinary) else { return }
                user.uid = snapshot.ref.key
                
                if user.uid != Auth.auth().currentUser?.uid {
                    users.append(user)
                }
                
                DispatchQueue.main.async {
                    self?.timer?.invalidate()
                    self?.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
                        self?.view?.update(users: users)
                    })
                }
        }) { [weak self] (error) in
            self?.view?.showError(message: error.localizedDescription)
        }
    }
    
    func openChat(with user: User) {
        router?.route(to: .chat(user: user))
    }
}
