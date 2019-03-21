//
//  SettingsSettingsRouter.swift
//  project
//
//  Created by Zakhar Babkin on 06/12/2018.
//  Copyright © 2018 Zachary Babkin. All rights reserved.
//

import UIKit

class SettingsRouter: Router {
    typealias RoutableType = SettingsViewModel
    typealias Context = UINavigationController

    weak var context: Context?

    func route(to route: SettingsViewModel.Routes) {
        switch route {
        case .logout:
            let authModule = AuthorizationBuilder().module
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.window?.rootViewController = authModule
        }
    }
}
