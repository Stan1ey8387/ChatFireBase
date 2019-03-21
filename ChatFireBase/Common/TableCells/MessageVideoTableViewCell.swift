//
//  MessageVideoTableViewCell.swift
//  ChatFireBase
//
//  Created by Захар Бабкин on 11/12/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit

protocol MessageVideoTableViewCellDelegate: class {
    func selected(video: URL, previewImage: Data)
}

class MessageVideoTableViewCell: MessageImageTableViewCell {
    weak var videoDelegate: MessageVideoTableViewCellDelegate?
    
    fileprivate var videoURL: URL?
    
    fileprivate var playPauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Play"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func configurate(with message: Message) {
        super.configurate(with: message)
        videoURL = URL(string: message.video ?? "")
        
        setupViews()
    }
    
    fileprivate func setupViews() {
        setupPlayPauseButton()
    }
    
    fileprivate func setupPlayPauseButton() {
        addSubview(playPauseButton)
        
        NSLayoutConstraint.activate([
            playPauseButton.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor),
            playPauseButton.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor)
            ])
        
        playPauseButton.addTarget(self, action: #selector(playPause), for: .touchUpInside)
    }
    
    @objc fileprivate func playPause() {
        guard let video = videoURL, let previewImage = photoImageView.image?.jpegData(compressionQuality: 1) else { return }
        videoDelegate?.selected(video: video, previewImage: previewImage)
        photoImageView.hero.id = "\(previewImage.count)"
    }
}
