//
//  User.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 29/11/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import Foundation

struct User {
    var uid: String?
    let name: String
    let email: String
    let photo: String?
    
    init?(dictionary: [String: Any]) {
        if let name = dictionary["name"] as? String, let email = dictionary["email"] as? String {
            self.uid = nil
            self.name = name
            self.email = email
            self.photo = dictionary["photo"] as? String
        } else {
            return nil
        }
    }
}
