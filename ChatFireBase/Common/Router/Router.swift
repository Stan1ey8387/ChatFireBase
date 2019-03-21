//
//  Router.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 29/11/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit


protocol Routable {
    associatedtype Routes
}

protocol Router {
    associatedtype RoutableType: Routable
    associatedtype Context: AnyObject
    
    var context: Context? { get set }
    
    func route(to route: RoutableType.Routes)
}

extension Router {
    func close(animated: Bool = true) {
        if let navigationController = context as? UINavigationController {
            navigationController.popViewController(animated: animated)
        } else if let viewController = context as? UIViewController {
            viewController.dismiss(animated: animated, completion: nil)
        }
    }
}
