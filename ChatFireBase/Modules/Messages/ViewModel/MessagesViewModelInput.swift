//
//  MessagesMessagesViewModelInput.swift
//  project
//
//  Created by Zakhar Babkin on 01/12/2018.
//  Copyright © 2018 Zachary Babkin. All rights reserved.
//

protocol MessagesViewModelInput {
    func fetchMessages()
    func chat(with user: User)
}
