//
//  AboutView.swift
//  BeAware
//
//  Created by Saamer Mansoor on 3/21/22.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        List(aboutItems) { item in
            AboutRow(aboutItem: item)
        }.navigationTitle("ABOUT US")
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

struct AboutRow: View {
    var aboutItem: About

    var body: some View {
        VStack(alignment: .leading) {
            Text(aboutItem.title)
                .font(Font.custom("Avenir", size: 24))
                .fontWeight(.heavy)
                .foregroundColor(Color("SecondaryColor"))
                .multilineTextAlignment(.leading)
                .padding(.top)
            
            Text(aboutItem.description)
                .font(Font.custom("Avenir", size: 18))
                .foregroundColor(Color("SecondaryColor"))
                .padding(.bottom)
        }
    }
}

struct About: Identifiable {
    let id = UUID()
    var title: String
    var description: String
}

var aboutItems: [About] = [
    About(title:NSLocalizedString("WHO", comment: "WHO"),
          description: NSLocalizedString("This app was ideated, designed and developed by a group of friends that met at the Apple Developer Academy in Detroit", comment: "1st section")),
    About(title:NSLocalizedString("WHY", comment: "WHY"),
          description: NSLocalizedString("Our goal for building this was to create an app that would improve the everyday tasks for people while being inclusive", comment: "Section 2")),
    About(title:NSLocalizedString("FEEDBACK", comment: "FEEDBACK"),
          description: NSLocalizedString("The app is far from perfect, but we would like to hear from you, to know what improvements to prioritize. Email us at hi@deafassistant.com",comment: "3rd section")),
    About(title:NSLocalizedString("CONTRIBUTE", comment: "CONTRIBUTE"),
          description: NSLocalizedString("We are using the latest iOS SwiftUI framework to build all parts of this app. The code is open source and so is the design. We would love your involvement and code pull requests", comment: "Last paragraph")),
]
