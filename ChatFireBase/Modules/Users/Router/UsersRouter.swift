//
//  UsersRouter.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 02/12/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit

class UsersRouter: Router {
    typealias RoutableType = UsersViewModel
    typealias Context = UINavigationController
    
    weak var context: Context?
    
    func route(to route: UsersViewModel.Routes) {
        switch route {
        case .chat(let user):
            let chatModule = СhatBuilder().set(user: user).module
        
            context?.viewControllers.first?.hidesBottomBarWhenPushed = true
            context?.pushViewController(chatModule, animated: true)
            context?.viewControllers.first?.hidesBottomBarWhenPushed = false
        }
    }
}
