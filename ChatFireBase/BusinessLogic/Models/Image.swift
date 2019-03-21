//
//  Image.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 06/12/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import Foundation

struct Image {
    let image: String
    let width: Float
    let height: Float
}

extension Image {
    init?(dictionary: [String: Any]) {
        if let image = dictionary["image"] as? String, let width = dictionary["width"] as? Float, let height = dictionary["height"] as? Float {
            self.image = image
            self.width = width
            self.height = height
        } else {
            return nil
        }
    }
}

extension Image {
    var dictionaryData: [String: Any] {
        let dictionaryData: [String : Any] = ["image": image,
                                              "width": width,
                                              "height": height]
        
        return dictionaryData
    }
}
