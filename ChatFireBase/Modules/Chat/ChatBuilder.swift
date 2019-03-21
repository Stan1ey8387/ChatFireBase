//
//  ChatBuilder.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 08/12/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit

class СhatBuilder: Builder {
    fileprivate var user: User?
    
    var module: UIViewController {
        guard let user = self.user else { fatalError("User is empty")}
        let chatViewController = ChatViewController()
        let chatViewModel = ChatViewModel(user: user)
        let chatRouter = ChatRouter()
        
        chatViewModel.view = chatViewController
        chatRouter.context = chatViewController
        chatViewModel.router = chatRouter
        chatViewController.viewModel = chatViewModel
        
        return chatViewController
    }
    
    func set(user: User) -> СhatBuilder {
        self.user = user
        return self
    }
}
