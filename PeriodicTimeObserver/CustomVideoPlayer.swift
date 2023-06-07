//
//  CustomVideoPlayer.swift
//  PeriodicTimeObserver
//
//  Created by Daniel Too on 7/06/23.
//

import SwiftUI

struct CustomVideoPlayer: View {
    
    @StateObject var viewModel = VideoPlayerViewModel()
    
    var body: some View {
        ZStack {
            if let avplayer = viewModel.avPlayer {
                VideoPlayerRepresentable(player: avplayer)
                VStack {
                    Spacer()
                    Text("TIME \(viewModel.currentProgress/viewModel.duration)")
                }
                .padding()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            viewModel.setupPlayer(for: URL(string: viewModel.testUrl2)!)
            viewModel.avPlayer?.play()
        }
        .onDisappear {
            viewModel.avPlayer?.pause()
        }
    }
}

struct CustomVideoPlayer_Previews: PreviewProvider {
    static var previews: some View {
        CustomVideoPlayer()
    }
}
