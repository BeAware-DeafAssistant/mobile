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
    Info(name:NSLocalizedString("Tutorial", comment: "Tutorial"), icon: "book"),
    Info(name:NSLocalizedString("About Us", comment: "About"), icon: "questionmark.app"),
    Info(name:NSLocalizedString("Video", comment:"Video"), icon: "video.and.waveform"),
    Info(name:NSLocalizedString("Widget", comment: "Widget"), icon: "character.textbox"),
    Info(name:NSLocalizedString("Share", comment: "Share"), icon: "square.and.arrow.up"),
    Info(name:NSLocalizedString("Contact Us", comment: "Contact Us"), icon: "envelope"),
    Info(name:NSLocalizedString("License Agreement", comment: "License Agreement"), icon: "applepencil"),
    Info(name:NSLocalizedString("Terms Of Use", comment: "Terms Of Use"), icon: "scroll"),
    Info(name:NSLocalizedString("Privacy Policy", comment: "Privacy Policy"), icon: "magnifyingglass.circle"),
    Info(name:NSLocalizedString("Rate The App", comment: "Rate The App"), icon: "star.fill"),
]
