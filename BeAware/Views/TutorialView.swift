//
//  dupIntroductionView.swift
//  BeAware
//
//  Created by Hitesh Parikh on 2/21/22.
//

import SwiftUI

struct TutorialView: View {
    var body: some View {
            ZStack{
                Color(hex: 0xFFFFFF)
                ScrollView{
                    VStack{
                        Spacer()
                        Text("Welcome to BeAware")
                            .font(Font.custom("Avenir", size: 18))
                            .fontWeight(.heavy)
                            .foregroundColor(Color(hex: 0x014579))
                            .padding()

                        Text("This app has 4 main functions:")
                            .font(Font.custom("Avenir", size: 18))
                            .foregroundColor(Color(hex: 0x014579))
                            .padding()
                                
                        VStack(alignment: .leading){
                            Text("\(Image(systemName: "mic")) Speech - Use this as a backup tool to convert speech to text\n")                .font(Font.custom("Avenir", size: 18))
                                .foregroundColor(Color(hex: 0x014579))

                            Text("\(Image(systemName: "waveform")) Alert - Be alerted of short or prolonged sounds\n")                .font(Font.custom("Avenir", size: 18))
                                .foregroundColor(Color(hex: 0x014579))

                            Text("\(Image(systemName: "keyboard")) Text - Use a text field to communicate, which can also be played into live phone calls")
                                .font(Font.custom("Avenir", size: 18))
                                .foregroundColor(Color(hex: 0x014579))

                            Text("\(Image(systemName: "checkerboard.rectangle")) Emoji Board - Select curated emojis or add ones to communicate easily\n")                        .font(Font.custom("Avenir", size: 18))
                                .foregroundColor(Color(hex: 0x014579))
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
//                                    .foregroundColor(Color(hex: 0xFFFFFF))
//                                    .background(Color(hex: 0x014579))
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

