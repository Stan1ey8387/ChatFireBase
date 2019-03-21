//
//  UIViewController + NVActivityIndicator.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 29/11/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

extension UIViewController: NVActivityIndicatorViewable {
    
    func startIndicator(message: String? = nil) {
        startAnimating(CGSize.init(width: 60, height: 60), message: message, type: .ballScale, color: .white)
    }
    
    func stopIndicator() {
        stopAnimating()
    }
}

