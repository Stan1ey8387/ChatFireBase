//
//  DetailImageDetailImageViewModelInput.swift
//  project
//
//  Created by Zakhar Babkin on 08/12/2018.
//  Copyright © 2018 Zachary Babkin. All rights reserved.
//

import Foundation

protocol DetailImageViewModelInput {
    var image: Data { get }
    
    func close()
}
