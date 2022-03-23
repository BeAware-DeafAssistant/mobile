//
//  SpeechView.swift
//  BeAware
//
//  Created by Saamer Mansoor on 2/7/22.
//
import SwiftUI
import MessageUI

struct SettingsView : View {
    @State private var showShareSheet = false
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false

    var body : some View {
        ZStack{
            Color("BrandColor")
            VStack {
                List(infoItems) { item in
                    if item.name == "Share"
                    {
                        Button(action: {
                            self.showShareSheet.toggle()
                        }) {
                            InfoRow(infoItem: item)
                        }
                    }
                    else if  MFMailComposeViewController.canSendMail() && item.name == "Contact Us"
                    {
                        Button(action: {
                            self.isShowingMailView.toggle()
                        }) {
                            InfoRow(infoItem: item)
                        }
                    }
                    else{
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
                            case "Share":
                                WidgetView()
                            case "Contact Us":
                                WebView(url: URL(string: "https://forms.gle/RbQxn7ymAAHWGSoy8")!).navigationTitle("CONTACT")
                            case "License Agreement":
                                WebView(url: URL(string: "https://github.com/philparkus/BeAware/blob/main/LICENSE")!).navigationTitle("LICENSE")
                            default:
                                VideoView()
                            }
                        } label:{
                            InfoRow(infoItem: item)
                        }
                    }
                }
                Spacer ()
            }
        }.navigationTitle("INFO")
            .navigationBarTitleTextColor(Color("SecondaryColor"))
            .sheet(isPresented: $showShareSheet) {
                        ShareSheet(activityItems: ["Hi! I downloaded BeAware- the deaf assistant for iPhones and I really think you should check it out. It has not been released to the public yet, so you can install a special free version through here: https://testflight.apple.com/join/3ixeJPSz"])
                    }
            .sheet(isPresented: $isShowingMailView) {
                MailView(isShowing: self.$isShowingMailView, result: self.$result)
            }
    }
}
struct SettingsView_Previews : PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
