//
//  DetailVideoDetailVideoViewModelOutput.swift
//  project
//
//  Created by Zakhar Babkin on 12/12/2018.
//  Copyright © 2018 Zachary Babkin. All rights reserved.
//

import UIKit

protocol DetailVideoViewModelOutput: class {
    func setVideoView(_ videoView: UIView)
    func setVideoLayer(_ videoLayer: CALayer)
    
    func updatePlayPause(isPlaying: Bool)
    func updatePlaybackPosition(currentTime: TimeInterval, duration: TimeInterval)
    
    func stopIndicator()
}
