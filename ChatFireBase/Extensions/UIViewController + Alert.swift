//
//  UIViewController + Alert.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 29/11/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit

extension UIViewController{
    func showAlert(_ title: String?, message: String?, titleAction: String?, cancelAction:Bool, handler: ((UIAlertAction) -> ())? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert )
            let action = UIAlertAction(title: titleAction, style: .default, handler: handler)
            
            alert.addAction(action)
            
            if cancelAction {let cancel = UIAlertAction (title: "Отмена", style: .cancel, handler: nil)
                alert.addAction(cancel)
            }
            self.present(alert, animated: true, completion: nil)
        }
    }
}
