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
                    // Using only Alert instead of NSLocalizedString("Alert", comment: "Alert Title"), doesn't work here
                    Label(NSLocalizedString("Alert", comment: "Alert Title"), systemImage: "bell.and.waveform.fill")
                }
            SpeechView()
                .tabItem {
                    Label(NSLocalizedString("Speech", comment: "Speech Title"), systemImage: "mic")
                }
            TextView ()
                .tabItem {
                    Label(NSLocalizedString("Text", comment: "Text Title"), systemImage: "keyboard")
                }
            EmojiBoardView()
                .tabItem {
                    Label(NSLocalizedString("Emoji Board", comment: "Emoji Board Title"), systemImage: "checkerboard.rectangle")
                }
        }
    }
}

struct MyTabView_Previews: PreviewProvider {
    static var previews: some View {
        MyTabView()
    }
}
