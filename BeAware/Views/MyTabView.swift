//
//  MyTabView.swift
//  BeAware
//
//  Created by Saamer Mansoor on 2/4/22.
//

import SwiftUI

struct MyTabView: View {
    var body: some View {
        TabView {
            AlertView ()
                .tabItem {
                    Label("Alert", systemImage: "waveform")
                }
            SpeechView()
                .tabItem {
                    Label("Speech", systemImage: "mic")
                }
            TextView ()
                .tabItem {
                    Label("Text", systemImage: "keyboard")
                }
            EmojiBoardView()
                .tabItem {
                    Label("Emoji Board", systemImage: "checkerboard.rectangle")
                }
        }
    }
}

struct MyTabView_Previews: PreviewProvider {
    static var previews: some View {
        MyTabView()
    }
}
