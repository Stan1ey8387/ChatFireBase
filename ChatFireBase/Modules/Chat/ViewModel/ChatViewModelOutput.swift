//
//  ChatChatViewModelOutput.swift
//  project
//
//  Created by Zakhar Babkin on 02/12/2018.
//  Copyright © 2018 Zachary Babkin. All rights reserved.
//

protocol ChatViewModelOutput: class {
    func update(messages: [Message])
    func showError(message: String)
}
