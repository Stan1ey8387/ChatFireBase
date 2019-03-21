//
//  DetailImageBuilder.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 08/12/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit


class DetailImageBuilder: Builder {
    fileprivate var image: Data?
    
    var module: UIViewController {
        guard let image = self.image else { fatalError("Image is empty")}
        
        let detailImageViewController = DetailImageViewController()
        let detailImageViewModel = DetailImageViewModel(image: image)
        let detailImageRouter = DetailImageRouter()
        
        detailImageRouter.context = detailImageViewController
        detailImageViewModel.router = detailImageRouter
        detailImageViewModel.view = detailImageViewController
        detailImageViewController.viewModel = detailImageViewModel
        
        return detailImageViewController
    }
    
    func set(image: Data) -> DetailImageBuilder {
        self.image = image
        return self
    }
}
