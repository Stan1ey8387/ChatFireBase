//
//  ChatChatRouter.swift
//  project
//
//  Created by Zakhar Babkin on 02/12/2018.
//  Copyright © 2018 Zachary Babkin. All rights reserved.
//

import UIKit

class ChatRouter: Router {
    typealias RoutableType = ChatViewModel
    typealias Context = UIViewController

    weak var context: Context?

    func route(to route: ChatViewModel.Routes) {
        switch route {
        case .openDetailImage(let image):
            let detailImageModule = DetailImageBuilder().set(image: image).module
            
            context?.present(detailImageModule, animated: true)
        case .openDetailVideo(let video, let previewImage):
            let detailVideoModule = DetailVideoBuilder().set(video: video).set(previewImage: previewImage).module
            
            context?.present(detailVideoModule, animated: true)
        }
    }
}
