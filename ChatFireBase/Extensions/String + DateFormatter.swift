//
//  DataFormatter.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 03/12/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import Foundation


extension String {
    func getDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +zzzz"
        dateFormatter.locale = Locale(identifier: "ru")
        
        guard let date = dateFormatter.date(from: self) else { return ""}
        dateFormatter.dateFormat = "HH:mm"
        let stringDate = dateFormatter.string(from: date)
        
        return stringDate
    }
    
    func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +zzzz"
        dateFormatter.locale = Locale(identifier: "ru")
        
        guard let date = dateFormatter.date(from: self) else { return nil}
        
        return date
    }
}
