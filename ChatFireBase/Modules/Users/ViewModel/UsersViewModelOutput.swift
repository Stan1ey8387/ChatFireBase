//
//  UsersViewModelOutput.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 29/11/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import Foundation

protocol UsersViewModelOutput: class {
    func update(users: [User])
    func showError(message: String)
}
