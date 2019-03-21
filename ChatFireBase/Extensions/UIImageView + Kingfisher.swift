//
//  UIImageView + Kingfisher.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 30/11/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(url: URL?, placeholder: UIImage? = nil, indicator: Bool = false) {
        self.kf.setImage(with: url, placeholder: placeholder)
        
        self.kf.indicatorType = indicator ? .activity : .none
    }
}
 
