//
//  MainTabBarController.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 05/12/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    fileprivate func setup() {
        let userModule = UsersBuilder().module
        
        userModule.tabBarItem = UITabBarItem(title: "Контакты", image: UIImage(named: "TabBar.Contacts"), selectedImage: UIImage(named: "TabBar.Contacts.isSelected"))
        userModule .tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
        
        let messagesModule = MessagesBuilder().module
        
        messagesModule.tabBarItem = UITabBarItem(title: "Сообщения", image: UIImage(named: "TabBar.Messages"), selectedImage: UIImage(named: "TabBar.Messages.isSelected"))
        messagesModule.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
        
        let settingsModule = SettingsBuilder().module
        
        settingsModule.tabBarItem = UITabBarItem(title: "Настройки", image: UIImage(named: "TabBar.Settings"), selectedImage: UIImage(named: "TabBar.Settings.isSelected"))
        settingsModule.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
        
        viewControllers = [userModule, messagesModule, settingsModule]
        selectedIndex = 1
    }
}
