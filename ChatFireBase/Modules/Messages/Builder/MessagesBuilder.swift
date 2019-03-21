//
//  MessagesBuilder.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 08/12/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit

class MessagesBuilder: Builder {
    var module: UIViewController {
        let messagesViewController = MessagesViewController()
        let messagesViewModel = MessagesViewModel()
        let messagesRouter = MessagesRouter()
        let messagesNavigationController = UINavigationController(rootViewController: messagesViewController)
        
        messagesRouter.context = messagesNavigationController
        messagesViewModel.view = messagesViewController
        messagesViewModel.router = messagesRouter
        messagesViewController.viewModel = messagesViewModel
        
        return messagesNavigationController
    }
}
