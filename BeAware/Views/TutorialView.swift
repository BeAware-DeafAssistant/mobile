//
//  dupIntroductionView.swift
//  BeAware
//
//  Created by Hitesh Parikh on 2/21/22.
//

import SwiftUI

struct TutorialView: View {
    private var idiom = UIDevice.current.userInterfaceIdiom == .pad ? "iPad" : "iPhone"
    
    var body: some View {
        ZStack{
            Color("BrandColor")
            ScrollView{
                VStack{
                    Spacer()
                    Text("Welcome to BeAware")
                        .font(Font.custom("Avenir", size: 18))
                        .fontWeight(.heavy)
                        .foregroundColor(Color("SecondaryColor"))
                        .padding()
                    
                    Text("This app has 4 main functions:")
                        .font(Font.custom("Avenir", size: 18))
                        .foregroundColor(Color("SecondaryColor"))
                        .padding()
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text("\(Image(systemName: "bell.and.waveform.fill")) ")
                                .foregroundColor(Color("SecondaryColor"))
                            Text(NSLocalizedString("Alert - Turn your device into an elite alerting tool with customizable alerts of short or prolonged sounds around you", comment: "ALERT") + "\n") // TODO: Use idiom instead of device
                                .font(Font.custom("Avenir", size: 18))
                                .foregroundColor(Color("SecondaryColor"))
                        }
                        HStack{
                            Text("\(Image(systemName: "mic")) ")
                                .foregroundColor(Color("SecondaryColor"))
                            
                            Text(NSLocalizedString("Speech - Take advantage of your phone's powerful speech-to-text capability to transcribe, even while the app is in the background", comment: "Speech") + "\n")
                                .font(Font.custom("Avenir", size: 18))
                                .foregroundColor(Color("SecondaryColor"))
                        }
                        HStack{
                            Text("\(Image(systemName: "keyboard")) ")
                                .foregroundColor(Color("SecondaryColor"))
                            Text(NSLocalizedString("Text - BeAware is the only app that can read text loud into you your live phone calls, assisted by customizable preset phrases", comment: "Text") + "\n")
                                .font(Font.custom("Avenir", size: 18))
                                .foregroundColor(Color("SecondaryColor"))
                        }
                        HStack{
                            Text("\(Image(systemName: "checkerboard.rectangle")) ")
                                .foregroundColor(Color("SecondaryColor"))
                            Text(NSLocalizedString("Emoji Board - Communicate using curated emojis or add images",
                                                   comment: "Emoji") + "\n")
                                .font(Font.custom("Avenir", size: 18))
                                .foregroundColor(Color("SecondaryColor"))
                        }
                    }.padding()
                    Spacer()
                }
            }
        }
        .navigationTitle("TUTORIAL")
        .navigationBarTitleTextColor(Color("SecondaryColor"))
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}

