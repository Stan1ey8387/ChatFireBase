//
//  UsersBuilder.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 08/12/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit

class UsersBuilder: Builder {
    var module: UIViewController {
        let usersViewController = UsersViewController()
        let usersViewModel = UsersViewModel()
        let usersRouter = UsersRouter()
        let usersNavigationController = UINavigationController(rootViewController: usersViewController)
        
        usersViewModel.view = usersViewController
        usersRouter.context = usersNavigationController
        usersViewModel.router = usersRouter
        usersViewController.viewModel = usersViewModel
        
        return usersNavigationController
    }
}
