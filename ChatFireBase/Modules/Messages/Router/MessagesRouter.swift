//
//  MessagesMessagesRouter.swift
//  project
//
//  Created by Zakhar Babkin on 01/12/2018.
//  Copyright © 2018 Zachary Babkin. All rights reserved.
//

import UIKit

class MessagesRouter: Router {
    typealias RoutableType = MessagesViewModel
    typealias Context = UINavigationController

    weak var context: Context?

    func route(to route: MessagesViewModel.Routes) {
        switch route {
        case .chat(let user):
            let chatModule = СhatBuilder().set(user: user).module
            
            context?.viewControllers.first?.hidesBottomBarWhenPushed = true
            context?.pushViewController(chatModule, animated: true)
            context?.viewControllers.first?.hidesBottomBarWhenPushed = false
        }
    }
}
