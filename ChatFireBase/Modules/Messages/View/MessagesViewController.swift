//
//  MessagesMessagesViewController.swift
//  project
//
//  Created by Zakhar Babkin on 01/12/2018.
//  Copyright © 2018 Zachary Babkin. All rights reserved.
//

import UIKit

final class MessagesViewController: UIViewController{
    public var viewModel: MessagesViewModelInput?
    
    fileprivate var messages = [Message]()
    
    fileprivate let tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(DialogTableViewCell.self, forCellReuseIdentifier: "DialogCell")
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        //startIndicator()
        viewModel?.fetchMessages()
    }
    
    fileprivate func setupViews() {
        navigationItem.title = "Messages"
        view.backgroundColor = .white
        
        setupTableView()
    }
    
    deinit {
        print("MessagesViewController deinit")
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

extension MessagesViewController: MessagesViewModelOutput {
    func update(messages: [Message]) {
        self.messages = messages
        tableView.reloadData()
        
        stopIndicator()
    }
    
    func showError(message: String) {
        stopIndicator()
        showAlert("Error", message: message, titleAction: "Repeat", cancelAction: false) { [weak self] (_) in
            self?.viewModel?.fetchMessages()
        }
    }
}

extension MessagesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DialogCell", for: indexPath) as? DialogTableViewCell
        let message = messages[indexPath.row]
        
        cell?.configurate(with: message)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = messages[indexPath.row].user else { return }
        viewModel?.chat(with: user)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
