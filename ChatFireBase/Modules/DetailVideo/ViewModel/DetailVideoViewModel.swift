//
//  DetailVideoDetailVideoViewModel.swift
//  project
//
//  Created by Zakhar Babkin on 12/12/2018.
//  Copyright © 2018 Zachary Babkin. All rights reserved.
//

import UIKit
import AVFoundation

final class DetailVideoViewModel: DetailVideoViewModelInput, Routable {
    weak var view: DetailVideoViewModelOutput?
    var router: DetailVideoRouter?
    
    var previewImage: Data
    
    fileprivate var video: URL
    fileprivate var player = Player()
    fileprivate var playerIsReady = false

    enum Routes {
    }
    
    init(video: URL, previewImage: Data) {
        self.previewImage = previewImage
        self.video = video
    }
    
    func configuratePlayer(on viewController: UIViewController) {
        player.playerDelegate = self
        player.playbackDelegate = self

        player.url = video
        player.fillMode = .resizeAspect
    }
    
    func playPause() {
        if player.playbackState == .stopped || player.playbackState == .paused {
            if playerIsReady {
                player.playFromCurrentTime()
            } else {
                player.url = video
            }
        } else if player.playbackState == .playing {
            player.pause()
        }
    }
    
    func set(time: Float) {
        let cmtime = CMTime(seconds: Double(TimeInterval(time)), preferredTimescale: 1000)
        player.seek(to: cmtime)
    }
    
    func close() {
        router?.close()
    }
}

extension DetailVideoViewModel: PlayerDelegate {
    func playerReady(_ player: Player) {
        playerIsReady = true
        view?.setVideoView(player.playerView)
        player.playFromBeginning()
    }
    
    func playerPlaybackStateDidChange(_ player: Player) {
        view?.stopIndicator()
        if player.playbackState == .stopped || player.playbackState == .paused{
            view?.updatePlayPause(isPlaying: false)
        } else if player.playbackState == .playing {
            view?.updatePlayPause(isPlaying: true)
        }
    }
    
    func playerBufferingStateDidChange(_ player: Player) {}
    
    func playerBufferTimeDidChange(_ bufferTime: Double) {}
    
    func player(_ player: Player, didFailWithError error: Error?) {
        print("player ERRRROR",error!.localizedDescription)
    }
}
extension DetailVideoViewModel: PlayerPlaybackDelegate {
    
    func playerCurrentTimeDidChange(_ player: Player) {
        guard !player.currentTime.isNaN && !player.maximumDuration.isNaN else { return }
        view?.updatePlaybackPosition(currentTime: player.currentTime, duration: player.maximumDuration)
    }
    
    func playerPlaybackWillStartFromBeginning(_ player: Player) {
    }
    
    func playerPlaybackDidEnd(_ player: Player) {
        self.player.stop()
    }
    
    func playerPlaybackWillLoop(_ player: Player) {}
}
