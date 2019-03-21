//
//  SettingsSettingsViewController.swift
//  project
//
//  Created by Zakhar Babkin on 06/12/2018.
//  Copyright © 2018 Zachary Babkin. All rights reserved.
//

import UIKit

final class SettingsViewController: UIViewController{
    public var viewModel: SettingsViewModelInput?
    
    fileprivate lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupsViews()
    }
    
    deinit {
        print("SettingsViewController deinit")
    }
    
    fileprivate func setupsViews() {
        view.backgroundColor = .red
        navigationItem.title = "Settings"
        setupLogoutButton()
    }
    
    fileprivate func setupLogoutButton() {
        view.addSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            logoutButton.widthAnchor.constraint(equalToConstant: 100),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
    }
    
    @objc fileprivate func logout() {
        viewModel?.logout()
    }
}

extension SettingsViewController: SettingsViewModelOutput {

}
