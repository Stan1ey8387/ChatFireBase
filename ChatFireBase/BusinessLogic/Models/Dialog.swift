//
//  Dialog.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 02/12/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import Foundation


struct Dialog {
    let id: String
    let toUserId: String
    let fromUserId: String
    let dataCreate: String
}

extension Dialog {
    var dictionaryData: [String: Any] {
        return ["id": id,
                "toUserId": toUserId,
                "fromUserId": fromUserId,
                "dataCreate": dataCreate
                ]
    }
}
