//
//  VideoPlayerRepresentable.swift
//  PeriodicTimeObserver
//
//  Created by Daniel Too on 7/06/23.
//

import SwiftUI
import AVFoundation

struct VideoPlayerRepresentable: UIViewRepresentable {
    let player: AVPlayer
    let playerLayer: AVPlayerLayer
    
    class PlayerContainer: UIView {
        init(playerLayer: AVPlayerLayer) {
            super.init(frame: .zero)
            layer.addSublayer(playerLayer)
        }
        
        required init?(coder: NSCoder) {
            fatalError("we're not using this initializer")
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            layer.sublayers?.first?.frame = bounds
        }
    
    }

    init(player: AVPlayer) {
        self.player = player
        self.playerLayer = AVPlayerLayer(player: player)
    }
     
    func makeUIView(context: Context) -> UIView {
        return PlayerContainer(playerLayer: playerLayer)
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        guard let playerLayer = uiView.layer.sublayers?.first as? AVPlayerLayer else {
            return
        }
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill        
    }
    
    func play() {
        let currentItem = player.currentItem
        if currentItem?.currentTime() == currentItem?.duration {
            currentItem?.seek(to: .zero, completionHandler: nil)
        }
        
        player.play()
    }
    
    func pause() {
        player.pause()
    }
}
