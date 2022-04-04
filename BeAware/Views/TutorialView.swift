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
                            Text("\(Image(systemName: "waveform")) Alert - Turn your device into an elite alerting tool with customizable alerts of short or prolonged sounds around you\n") // TODO: Use idiom instead of device
                                .font(Font.custom("Avenir", size: 18))
                                .foregroundColor(Color("SecondaryColor"))

                            Text("\(Image(systemName: "mic")) Speech - Take advantage of your phone's powerful speech-to-text capability to transcribe, even while the app is in the background\n")
                                .font(Font.custom("Avenir", size: 18))
                                .foregroundColor(Color("SecondaryColor"))

                            Text("\(Image(systemName: "keyboard")) Text - BeAware is the only app that can read text loud into you your live phone calls, assisted by customizable preset phrases\n")
                                .font(Font.custom("Avenir", size: 18))
                                .foregroundColor(Color("SecondaryColor"))

                            Text("\(Image(systemName: "checkerboard.rectangle")) Emoji Board - Communicate using curated emojis or add images")
                                .font(Font.custom("Avenir", size: 18))
                                .foregroundColor(Color("SecondaryColor"))
                        }.padding()
                        Spacer()
//                        Button(
//                            action: {
//                                print("Hi")
//                                self.isActive = true
//                            }
//                        ){
//                                    Text("Continue")
//                                        .fontWeight(.semibold)
//                                        .font(Font.custom("Avenir", size: 18))
//                                        .frame(width: 190)
//                                    .padding()
//                                    .foregroundColor(Color("BrandColor"))
//                                    .background(Color("SecondaryColor"))
//
//                        }   .cornerRadius(8)
                        Spacer()
                    }
                }
            }
        // }
        .navigationTitle("TUTORIAL")
        .navigationBarTitleTextColor(Color("SecondaryColor"))
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}

