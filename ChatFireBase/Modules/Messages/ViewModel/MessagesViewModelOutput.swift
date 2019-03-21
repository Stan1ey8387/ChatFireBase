//
//  MessagesMessagesViewModelOutput.swift
//  project
//
//  Created by Zakhar Babkin on 01/12/2018.
//  Copyright © 2018 Zachary Babkin. All rights reserved.
//

protocol MessagesViewModelOutput: class {
    func update(messages: [Message])
    func showError(message: String)
}
