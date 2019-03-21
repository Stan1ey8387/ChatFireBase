//
//  DetailImageDetailImageViewController.swift
//  project
//
//  Created by Zakhar Babkin on 08/12/2018.
//  Copyright © 2018 Zachary Babkin. All rights reserved.
//

import UIKit

final class DetailImageViewController: UIViewController{
    public var viewModel: DetailImageViewModelInput?
    
    fileprivate var zoomImageView: ZoomImageView = {
        let imageView = ZoomImageView()
        imageView.image = UIImage(named: "ImagePlaceholder")
        imageView.zoomMode = .fit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        zoomImageView.image = UIImage(data: viewModel!.image)
        
        hero.isEnabled = true
        zoomImageView.imageView.hero.id = "\(viewModel!.image.count)"
    }
    
    deinit {
        print("DetailImageViewController deinit")
    }
    
    fileprivate func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.75)
        
        setupZoomImageView()
    }
    
    fileprivate func setupZoomImageView() {
        view.addSubview(zoomImageView)
        
        NSLayoutConstraint.activate([
            zoomImageView.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor),
            zoomImageView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            zoomImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            zoomImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            zoomImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(close))
        downSwipe.direction = .down
        zoomImageView.addGestureRecognizer(downSwipe)
    }
    
    // Selectors
    
    @objc fileprivate func close() {
        guard zoomImageView.zoomScale == 1 else { return }
        viewModel?.close()
    }
}

extension DetailImageViewController: DetailImageViewModelOutput {

}
