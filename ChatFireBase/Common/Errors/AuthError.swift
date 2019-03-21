//
//  AuthErrors.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 29/11/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import Foundation


enum AuthError: Error {
    case incorrectName
    case incorrectEmail
    case incorrectPassword
    case serverResponse
}

extension AuthError: LocalizedError {
    public var description: String {
        switch self {
        case .incorrectName: return NSLocalizedString("Incorrect introduced name.", comment: "")
        case .incorrectEmail: return NSLocalizedString("Incorrect introduced email.", comment: "")
        case .incorrectPassword: return NSLocalizedString("Incorrect introduced password.", comment: "")
        case .serverResponse: return NSLocalizedString("Server error.", comment: "")
        }
    }
}
