//
//  SpeechView.swift
//  BeAware
//
//  Created by Saamer Mansoor on 2/7/22.
//
import SwiftUI

struct SettingsView : View {
    var body : some View {
        ZStack{
            Color("BrandColor")
            VStack {
                List(infoItems) { item in
                    NavigationLink{
                        switch item.name{
                        case "Video":
                            VideoView()
                        case "Tutorial":
                            TutorialView()
                        case "About":
                            AboutView()
                        case "Widget":
                            WidgetView()
                        case "License Agreement":
                            WebView(url: URL(string: "https://github.com/philparkus/BeAware/blob/main/LICENSE")!).navigationTitle("LICENSE")
                        default:
                            VideoView()
                        }
                    } label:{
                        InfoRow(infoItem: item)
                    }
                }
                //            HStack {
                //             Link("License Agreement", destination: URL(string: "https://www.apple.com")!)
                //             .font(Font.custom("Avenir", size: 24))
                //             .foregroundColor(Color (hex: 0x014579))
                //             .padding(.leading, 20)
                //             Spacer()
                //             Image(systemName: "chevron.right").padding(.trailing, 30)
                //             .font(Font.custom("Avenir", size: 24))
                //             .foregroundColor(Color (hex: 0x014579))
                //
                //             .padding(.trailing, 20)
                //             }
                //            HStack {
                //             NavigationLink(destination: TutorialView()) {
                //             Text("Tutorial")
                //             .font(Font.custom("Avenir", size: 24))
                //             .foregroundColor(Color (hex: 0x014579))
                //             .padding(.leading, 20)
                //             Spacer()
                //             Image(systemName: "chevron.right").padding(.trailing, 30)
                //             .font(Font.custom("Avenir", size: 24))
                //             .foregroundColor(Color (hex: 0x014579))
                //             .padding(.trailing, 20)
                //             }
                //             }
                //
                //            HStack {
                //             NavigationLink(destination: VideoView()) {
                //             Text("Video")
                //             .font(Font.custom("Avenir", size: 24))
                //             .foregroundColor(Color (hex: 0x014579))
                //             .padding(.leading, 20)
                //             Spacer()
                //             Image(systemName: "chevron.right").padding(.trailing, 30)
                //             .font(Font.custom("Avenir", size: 24))
                //             .foregroundColor(Color (hex: 0x014579))
                //             .padding(.trailing, 20)
                //             }
                //             }
                
                
                Spacer ()
            }
        }.navigationTitle("INFO")
            .navigationBarTitleTextColor(Color("SecondaryColor"))
    }
}
struct SettingsView_Previews : PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
