//
//  UIView.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 28/11/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit

enum Side {
    case height
    case width
    case top
    case bottom
}

extension UIView {
    func roundRadius(by side: Side = .height) {
        self.clipsToBounds = true
        switch side {
            case .height: self.layer.cornerRadius = self.frame.height / 2
            case .width: self.layer.cornerRadius = self.frame.width / 2
            
        default: fatalError()
        }
    }
}
