//
//  CriticalAlertsView.swift
//  BeAware
//
//  Created by Saamer Mansoor on 3/23/22.
//

import SwiftUI

struct CriticalAlertsView: View {
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    VStack(alignment:.leading) {
                        Text("What are Critical Alerts?")
                            .font(Font.custom("Avenir", size: 24))
                            .fontWeight(.heavy)
                            .foregroundColor(Color("SecondaryColor"))
                            .multilineTextAlignment(.leading)
                            .padding(.top)
                        Text("If you would like alerts to display even when the app is in Do Not Disturb/Focus modes, you can mark the alerts as critical.")
                            .font(Font.custom("Avenir", size: 18))
                            .foregroundColor(Color("SecondaryColor"))
                            .padding(.bottom)
                        Text("How to turn on LED Flash")
                            .font(Font.custom("Avenir", size: 24))
                            .fontWeight(.heavy)
                            .foregroundColor(Color("SecondaryColor"))
                            .multilineTextAlignment(.leading)
                            .padding(.top)
                        
                        Text("1. Open the Settings app, tap Accessibility, then tap Audio/Visual.")
                            .font(Font.custom("Avenir", size: 18))
                            .foregroundColor(Color("SecondaryColor"))
                            .padding(.bottom)
                        Text("2. Turn on LED Flash for Alerts.")
                            .font(Font.custom("Avenir", size: 18))
                            .foregroundColor(Color("SecondaryColor"))
                            .padding(.bottom)

                    }
                    Image("criticalAlert")
                    Text("To prevent LED flashes when your device is in silent mode, turn off Flash on Silent. LED Flash for Alerts works only when your device is locked.")
                        .font(Font.custom("Avenir", size: 18))
                        .foregroundColor(Color("SecondaryColor"))
                        .padding()
                    Spacer()
                }
                .padding(.horizontal)
            }
            .navigationTitle("CRITICAL ALERTS")
        }
    }
}

struct CriticalAlertsView_Previews: PreviewProvider {
    static var previews: some View {
        CriticalAlertsView()
    }
}
