//
//  DetailVideoDetailVideoBuilder.swift
//  project
//
//  Created by Zakhar Babkin on 12/12/2018.
//  Copyright © 2018 Zachary Babkin. All rights reserved.
//

import UIKit

class DetailVideoBuilder: Builder {
    fileprivate var video: URL?
    fileprivate var previewImage: Data?
    
    var module: UIViewController {
        guard let video = video else { fatalError("Video is empty") }
        guard let previewImage = previewImage else { fatalError("PreviewImage is empty") }
        
        let viewController = DetailVideoViewController()
        let viewModel = DetailVideoViewModel(video: video, previewImage: previewImage)
        let router = DetailVideoRouter()

        router.context = viewController
        viewModel.router = router
        viewModel.view = viewController
        viewController.viewModel = viewModel

        return viewController
    }
    
    func set(video: URL) -> DetailVideoBuilder {
        self.video = video
        return self
    }
    
    func set(previewImage: Data) -> DetailVideoBuilder {
        self.previewImage = previewImage
        return self
    }
}
