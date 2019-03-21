//
//  AuthorizationBuilder.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 07/12/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit

class AuthorizationBuilder: Builder {
    var module: UIViewController {
        let authViewController = AuthorizationViewController()
        let authViewModel = AuthorizationViewModel()
        let authRouter = AuthorizationRouter()
        
        let authNavigationController = UINavigationController(rootViewController: authViewController)
        
        authViewController.viewModel = authViewModel
        authViewModel.view = authViewController
        authRouter.context = authNavigationController
        authViewModel.router = authRouter
        
        return authNavigationController
    }
}
