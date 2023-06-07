//
//  ContentView.swift
//  PeriodicTimeObserver
//
//  Created by Daniel Too on 7/06/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CustomVideoPlayerNoVM()
                .tabItem {
                    Text("No ViewModel")
                }
            CustomVideoPlayer()
                .tabItem {
                    Text("With ViewModel")
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
