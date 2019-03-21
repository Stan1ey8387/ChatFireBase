//
//  AuthorizationRouter.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 29/11/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit

class AuthorizationRouter: Router {
    typealias RoutableType = AuthorizationViewModel
    typealias Context = UINavigationController
    
    weak var context: Context?
    
    func route(to route: AuthorizationViewModel.Routes) {
        switch route {
        case .mainTabBar:
            
            let mainTabBarController = MainTabBarController()
            
            context?.navigationBar.isHidden = true
            context?.setViewControllers([mainTabBarController], animated: false)
        }
    }
}
