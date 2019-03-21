//
//  Data+Image.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 06/12/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit

extension Data {
    func getImageSize() -> CGSize{
        return UIImage(data: self)?.size ?? .zero
    }
}
