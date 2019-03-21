//
//  ChatChatViewModelInput.swift
//  project
//
//  Created by Zakhar Babkin on 02/12/2018.
//  Copyright © 2018 Zachary Babkin. All rights reserved.
//

import Foundation

protocol ChatViewModelInput {
    var user: User { get }
    
    func fetchMessage()
    func sendMessage(text: String)
    func sendMessage(photoData: Data)
    func sendMessage(videoURL: URL)
    func close()
    
    func openDetailImage(with image: Data)
    func openDetailVideo(with video: URL, previewImage: Data)
}
