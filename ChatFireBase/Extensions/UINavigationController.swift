//
//  UINavigationController.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 02/12/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit

extension UINavigationController {
    func popViewController(animated: Bool = true, completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popViewController(animated: animated)
        CATransaction.commit()
    }
    func pushViewController(viewController: UIViewController, animated: Bool = true, completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
}
