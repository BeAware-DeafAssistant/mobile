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
                    Label(NSLocalizedString("ALERT", comment: "Alert Title"), systemImage: "waveform")
                }
            SpeechView()
                .tabItem {
                    Label(NSLocalizedString("SPEECH", comment: "Speech Title"), systemImage: "mic")
                }
            TextView ()
                .tabItem {
                    Label(NSLocalizedString("TEXT", comment: "Text Title"), systemImage: "keyboard")
                }
            EmojiBoardView()
                .tabItem {
                    Label(NSLocalizedString("EMOJI BOARD", comment: "Emoji Board Title"), systemImage: "checkerboard.rectangle")
                }
        }
    }
}

struct MyTabView_Previews: PreviewProvider {
    static var previews: some View {
        MyTabView()
    }
}
