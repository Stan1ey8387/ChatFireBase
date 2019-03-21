//
//  AuthorizationViewModelInput.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 29/11/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import Foundation

protocol AuthorizationViewModelInput {
    func registration(name: String?, email: String?, password: String?, photo: Data?) throws
    func auth(email: String?, password: String?) throws
}
