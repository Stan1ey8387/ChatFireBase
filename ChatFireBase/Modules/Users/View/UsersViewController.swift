//
//  UsersViewController.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 29/11/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    public var viewModel: UsersViewModelInput?
    
    fileprivate var users = [User]()
    
    fileprivate let tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.isHidden = true
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        //startIndicator()
        viewModel?.fetchUsers()
    }
    
    deinit {
        print("UsersViewController deinit")
    }
    
    fileprivate func setupView() {
        navigationItem.title = "Users"
        view.backgroundColor = .white
        setupTableView()
    }
    
    fileprivate func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension UsersViewController: UsersViewModelOutput {
    func update(users: [User]) {
        self.users = users
        
        tableView.isHidden = false
        tableView.reloadData()
        
        stopAnimating()
    }
    
    func showError(message: String) {
        stopIndicator()
        showAlert("Error", message: message, titleAction: "Repeat", cancelAction: false) { [weak self] (_) in
            self?.viewModel?.fetchUsers()
        }
    }
}

extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserTableViewCell
        let user = users[indexPath.row]
        
        cell?.configurate(with: user)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = users[indexPath.row]
        viewModel?.openChat(with: selectedUser)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
