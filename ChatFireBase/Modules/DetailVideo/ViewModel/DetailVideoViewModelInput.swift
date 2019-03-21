//
//  DetailVideoDetailVideoViewModelInput.swift
//  project
//
//  Created by Zakhar Babkin on 12/12/2018.
//  Copyright © 2018 Zachary Babkin. All rights reserved.
//

import UIKit

protocol DetailVideoViewModelInput {
    var previewImage: Data { get }
    
    func configuratePlayer(on viewController: UIViewController)
    func playPause()
    func set(time: Float)
    
    func close()
}
