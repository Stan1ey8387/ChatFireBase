//
//  Message.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 02/12/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import Foundation

enum MessageType: String {
    case text = "text"
    case image = "image"
    case video = "video"
    case none = ""
}

struct Message {
    var type: MessageType
    let text: String?
    let image: Image?
    var video: String?
    let toUserId: String
    let fromUserId: String
    let dataCreate: String
    
    var user: User?
}

extension Message {
    init?(dictionary: [String: Any]) {
        if let toUserId = dictionary["toUserId"] as? String,
            let fromUserId = dictionary["fromUserId"] as? String, let dataCreate = dictionary["dataCreate"] as? String {
            self.type = MessageType(rawValue: (dictionary["type"] as? String) ?? "") ?? .none
            self.text = dictionary["text"] as? String
            self.image = Image(dictionary: dictionary["image"] as? [String: Any] ?? [:])
            self.video = dictionary["video"] as? String
            self.toUserId = toUserId
            self.fromUserId = fromUserId
            self.dataCreate = dataCreate
        } else {
            return nil
        }
    }
}

extension Message {
    var dictionaryData: [String: Any] {
        var dictionaryData: [String: Any] = ["type": type.rawValue,
                                             "toUserId": toUserId,
                                             "fromUserId": fromUserId,
                                             "dataCreate": dataCreate]
        switch type {
        case .text:
            guard let text = text else { break }
            dictionaryData.updateValue(text, forKey: "text")
        case .image:
            guard let image = image else { break }
            dictionaryData.updateValue(image.dictionaryData, forKey: "image")
        case .video:
            guard let video = video else { break }
            dictionaryData.updateValue(video, forKey: "video")
            
            guard let image = image else { break }
            dictionaryData.updateValue(image.dictionaryData, forKey: "image")
        case .none:
            break
        }
        
        return dictionaryData
    }
}
