//
//  AppDelegate.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 28/11/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        if Auth.auth().currentUser != nil {
            showMainTabBar()
        } else {
            showAuthVC()
        }
        
        return true
    }
    
    fileprivate func showAuthVC() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = AuthorizationBuilder().module
        window?.makeKeyAndVisible()
    }
    
    fileprivate func showMainTabBar() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainTabBarController = MainTabBarController()
        let navigationController = UINavigationController(rootViewController: mainTabBarController)
        navigationController.navigationBar.isHidden = true
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

