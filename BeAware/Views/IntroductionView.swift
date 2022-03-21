//
//  ContentView.swift
//  BeAware
//
//  Created by Saamer Mansoor on 2/2/22.
//

import SwiftUI

struct IntroductionView: View {
    @AppStorage("DidShowIntroductionView") var isActive:Bool = false
    var body: some View {
        if self.isActive {
            // 3.
            MyTabView()
        }
        else{
            ZStack{
                    Color(hex: 0x014579)
                        .ignoresSafeArea()
                ScrollView{
                    VStack{
                        Spacer()
                        Text("Welcome to BeAware")
                            .font(Font.custom("Avenir", size: 18))
                            .fontWeight(.heavy)
                            .foregroundColor(Color(hex: 0xFFFFFF))
                            .padding()

                        Text("This app has 4 main functions:")
                            .font(Font.custom("Avenir", size: 18))
                            .foregroundColor(Color(hex: 0xFFFFFF))
                            .padding()
                                
                        VStack(alignment: .leading){
                            Text("\(Image(systemName: "mic")) Speech - Use this as a backup tool to convert speech to text\n")                .font(Font.custom("Avenir", size: 18))
                                .foregroundColor(Color(hex: 0xFFFFFF))

                            Text("\(Image(systemName: "waveform")) Alert - Be alerted of short or prolonged sounds\n")                .font(Font.custom("Avenir", size: 18))
                                .foregroundColor(Color(hex: 0xFFFFFF))

                            Text("\(Image(systemName: "checkerboard.rectangle")) Emoji Board - Select curated emojis or add ones to communicate easily\n")                        .font(Font.custom("Avenir", size: 18))
                                .foregroundColor(Color(hex: 0xFFFFFF))

                            Text("\(Image(systemName: "keyboard")) Text - Use a text field to communicate")
                                .font(Font.custom("Avenir", size: 18))
                                .foregroundColor(Color(hex: 0xFFFFFF))
                        }.padding()
                        Spacer()
                        Button(
                            action: {
                                simpleSuccessHaptic()
                                self.isActive = true
                            }
                        ){
                                    Text("Continue")
                                        .fontWeight(.semibold)
                                        .font(Font.custom("Avenir", size: 18))
                                        .frame(width: 190)
                                    .padding()
                                    .foregroundColor(Color(hex: 0x014579))
                                    .background(Color(hex: 0xFFFFFF))

                        }.padding(.top, 20.00)   .cornerRadius(8)
                        Spacer()
                    }
                    .padding(.top, 30.0)
                }
            }
        }
    }
}

struct IntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionView()
    }
}
