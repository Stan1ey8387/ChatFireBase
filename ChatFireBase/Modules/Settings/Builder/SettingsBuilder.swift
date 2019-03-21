//
//  SettingsBuilder.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 08/12/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit

class SettingsBuilder: Builder {
    var module: UIViewController {
        let settingsViewController = SettingsViewController()
        let settingsViewModel = SettingsViewModel()
        let settingsRouter = SettingsRouter()
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        
        settingsRouter.context = settingsNavigationController
        settingsViewModel.view = settingsViewController
        settingsViewModel.router = settingsRouter
        settingsViewController.viewModel = settingsViewModel
        
        return settingsNavigationController
    }
}
