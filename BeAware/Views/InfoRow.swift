//
//  InfoRow.swift
//  BeAware
//
//  Created by Saamer Mansoor on 3/21/22.
//
import Foundation
import SwiftUI

struct InfoRow: View {
    var infoItem: Info

    var body: some View {
        HStack {
            Image(systemName: infoItem.icon)
            Text(infoItem.name)
                .font(Font.custom("Avenir", size: 18))
            Spacer()
        }
    }
}

struct InfoRow_Previews: PreviewProvider {
    static var previews: some View {
        InfoRow(infoItem: infoItems[0])
    }
}

struct Info: Identifiable {
    let id = UUID()
    var name: String
    var icon: String
}

var infoItems: [Info] = [
    Info(name:"Tutorial", icon: "book"),
    Info(name:"About", icon: "questionmark.app"),
    Info(name:"Video", icon: "video.and.waveform"),
    Info(name:"Widget", icon: "character.textbox"),
    Info(name:"Share", icon: "square.and.arrow.up"),
    Info(name:"Contact Us", icon: "envelope"),
    Info(name:"License Agreement", icon: "applepencil"),
    Info(name:"Terms Of Use", icon: "scroll"),
]
