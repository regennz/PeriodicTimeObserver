//
//  CustomVideoPlayerViewModel.swift
//  PeriodicTimeObserver
//
//  Created by Daniel Too on 7/06/23.
//

import Foundation
import AVFoundation
import Combine

class VideoPlayerViewModel: ObservableObject {
    @Published var currentProgress: TimeInterval = 0
    @Published var duration: TimeInterval = 1
    @Published var isPlaying: Bool = false
    @Published var avPlayer: AVPlayer?
    
    private var timeObserver: Any?
    private var cancellables: [AnyCancellable] = []
    
    let testUrl = "https://stream.mux.com/ErTp9TC01OQbfjMW81NC01hO6Gmp3pn0002D.m3u8"
    let testUrl2 = "https://cdn.flowplayer.com/a30bd6bc-f98b-47bc-abf5-97633d4faea0/hls/de3f6ca7-2db3-4689-8160-0f574a5996ad/playlist.m3u8"
    
    func setupPlayer(for url: URL) {
        avPlayer = AVPlayer(url: url)
        
        // listen to the "rate" to figure out if it is playing
        avPlayer?.publisher(for: \.rate)
            .sink { [weak self] rate in
                self?.isPlaying = rate > 0
            }
            .store(in: &cancellables)
        
        updateDuration()
        
        addPeriodicTimeObserver()
                
    }
    
    func addPeriodicTimeObserver() {
        // Notify every half second
        // this code is from https://developer.apple.com/documentation/avfoundation/avplayer/1385829-addperiodictimeobserver
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)

        print("-- TIME OBSERVER ADDED")
        
        timeObserver = avPlayer?.addPeriodicTimeObserver(forInterval: time,
                                                          queue: .main) {
            [weak self] time in

            print("TIME: \(time.seconds)")

            // MARK: - HERE IS THE ISSUE
            /*
             Before I add code here, the print statement will fire every 0.5 seconds as expected.
             
             After I add this line of code, it fires very very quickly.
             */
//            self?.currentProgress = time.seconds
        }
        
    }
    

    func updateDuration() {
        Task {
            if let duration = try await self.avPlayer?.currentItem?.asset.load(.duration) {
                DispatchQueue.main.async {
                    self.duration = duration.seconds
                }
            }
        }
    }
    func removePeriodicTimeObserver() {
        if let timeObserver = timeObserver {
            avPlayer?.removeTimeObserver(timeObserver)
            self.timeObserver = nil
        }        
    }
    
    deinit {
        removePeriodicTimeObserver()
    }
}
