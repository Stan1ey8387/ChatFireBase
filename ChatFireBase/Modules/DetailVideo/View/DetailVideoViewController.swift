//
//  DetailVideoDetailVideoViewController.swift
//  project
//
//  Created by Zakhar Babkin on 12/12/2018.
//  Copyright © 2018 Zachary Babkin. All rights reserved.
//

import UIKit

final class DetailVideoViewController: UIViewController{
    public var viewModel: DetailVideoViewModelInput?
    
    fileprivate var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    fileprivate var playPauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Play"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    fileprivate var rewindSlider: UISlider = {
        let slider = UISlider()
        slider.thumbTintColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        slider.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        slider.setThumbImage(UIImage(named: "Thumb"), for: .normal)
        slider.setThumbImage(UIImage(named: "Thumb"), for: .highlighted)
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        return slider
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hero.isEnabled = true
        previewImageView.image = UIImage(data: viewModel!.previewImage)
        previewImageView.hero.id = "\(viewModel!.previewImage.count)"
        
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startIndicator()
        viewModel?.configuratePlayer(on: self)
    }
    
    deinit {
        print("DetailVideoViewController deinit")
    }

    fileprivate func setupViews() {
        
        setupPreviewImageView()
        setupPlayPauseButton()
        setupRewindSlider()
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(close))
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hidePlayerControl)))
    }
    
    fileprivate func setupPreviewImageView() {
        view.addSubview(previewImageView)
        
        NSLayoutConstraint.activate([
            previewImageView.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor),
            previewImageView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            previewImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            previewImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            previewImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        
        previewImageView.layoutIfNeeded()
    }
    
    fileprivate func setupPlayPauseButton() {
        view.addSubview(playPauseButton)
        
        NSLayoutConstraint.activate([
            playPauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playPauseButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        
        playPauseButton.addTarget(self, action: #selector(playPause), for: .touchUpInside)
    }
    
    fileprivate func setupRewindSlider() {
        view.addSubview(rewindSlider)
        
        NSLayoutConstraint.activate([
            rewindSlider.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            rewindSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            rewindSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ])
        
        rewindSlider.addTarget(self, action: #selector(setTime(_:)), for: .valueChanged)
    }
    
    // Selectors
    
    @objc fileprivate func playPause() {
        viewModel?.playPause()
    }
    
    @objc fileprivate func setTime(_ sender: UISlider) {
        viewModel?.set(time: sender.value)
    }
    
    @objc fileprivate func hidePlayerControl() {
        playPauseButton.isHidden = !playPauseButton.isHidden
        rewindSlider.isHidden = !rewindSlider.isHidden
    }
    
    @objc fileprivate func close() {
        viewModel?.close()
    }
}

extension DetailVideoViewController: DetailVideoViewModelOutput {
    func setVideoView(_ videoView: UIView) {
        videoView.frame = previewImageView.bounds
        previewImageView.alpha = 0
        view.insertSubview(videoView, at: 0)
    }
    
    func setVideoLayer(_ videoLayer: CALayer) {
        videoLayer.frame = previewImageView.bounds
        previewImageView.layer.addSublayer(videoLayer)
    }
    
    func updatePlayPause(isPlaying: Bool) {
        if isPlaying {
            playPauseButton.setImage(UIImage(named: "Pause"), for: .normal)
        } else {
            playPauseButton.setImage(UIImage(named: "Play"), for: .normal)
        }
    }
    
    func updatePlaybackPosition(currentTime: TimeInterval, duration: TimeInterval) {
        rewindSlider.setValue(Float(currentTime), animated: true)
        rewindSlider.maximumValue = Float(duration)
    }
}
