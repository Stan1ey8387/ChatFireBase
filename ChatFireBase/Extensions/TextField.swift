//
//  TextField.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 02/12/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit

extension UITextField {
    func setBottomBorder(color: UIColor = .gray, width: CGFloat = 1) {
        self.layoutIfNeeded()
        
        borderStyle = .none
        let border = CALayer()
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width,
                              width: frame.size.width - 10, height: frame.size.height)
        
        border.borderWidth = width
        layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
