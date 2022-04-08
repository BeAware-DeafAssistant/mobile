//
//  WidgetView.swift
//  BeAware
//
//  Created by Saamer Mansoor on 3/21/22.
//

import SwiftUI

struct WidgetView: View {
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    VStack(alignment:.leading) {
                        Text("What does the Widget Show?")
                            .font(Font.custom("Avenir", size: 24))
                            .fontWeight(.heavy)
                            .foregroundColor(Color("SecondaryColor"))
                            .multilineTextAlignment(.leading)
                            .padding(.top)
                        Text("If you would like view the status of your noise alert running in the background, you can add the widget to your home screen.")
                            .font(Font.custom("Avenir", size: 18))
                            .foregroundColor(Color("SecondaryColor"))
                            .padding(.bottom)
                        Text("Adding the widget")
                            .font(Font.custom("Avenir", size: 24))
                            .fontWeight(.heavy)
                            .foregroundColor(Color("SecondaryColor"))
                            .multilineTextAlignment(.leading)
                            .padding(.top)
                        Text("1. From the Home Screen, touch and hold a widget or an empty area until the apps jiggle.")                .font(Font.custom("Avenir", size: 18))
                            .foregroundColor(Color("SecondaryColor"))
                            .padding(.bottom)

                        Text("2. Tap the Add button (+) in the upper-left corner.")                .font(Font.custom("Avenir", size: 18))
                            .foregroundColor(Color("SecondaryColor"))
                            .padding(.bottom)

                        Text("3. Select the BeAware widget and then tap Add Widget and then tap Done.")
                            .font(Font.custom("Avenir", size: 18))
                            .foregroundColor(Color("SecondaryColor"))
                            .padding(.bottom)
                    }
                    Image("widget")
                    Spacer()
                }
                .padding(.horizontal)
            }
            .navigationTitle("WIDGET")
        }
    }
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView()
    }
}
