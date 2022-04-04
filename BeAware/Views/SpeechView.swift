//
//  SpeechView.swift
//  BeAware
//
//  Created by Saamer Mansoor on 2/7/22.
//
import AVFoundation
import SwiftUI
import Speech
import WidgetKit
//private let speechRecognizer = SFSpeechRecognizer()

struct SpeechView : View {
    @StateObject var speechRecognizer = SpeechRecognizer() // StateObject and not Observed object because there's only one source of truth, so you'll only have one source of truth for the whole app
    @State private var isRecording = false
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }

    var body : some View {
        NavigationView{
            
            ZStack {
                Color("BrandColor")
                VStack{
                    VStack{
                        Text("I can’t hear you clearly.  I use this tool to understand what people are saying. Please speak into the mic")
                            .font(Font.custom("Avenir", size: 24))
                            .padding(.top, 20)
                            .padding([.leading, .trailing], 30.0)
                            .foregroundColor(Color("SecondaryColor"))
                            .frame(maxHeight: .infinity)
                    }
                    .fixedSize(horizontal: false, vertical: true)

                    Button(action: {
                        Task
                        {
                            isRecording.toggle()
                            if isRecording{
                                simpleEndHaptic()
                                if let userDefaults = UserDefaults(suiteName: "group.com.tfp.beaware") {
                                    userDefaults.setValue("transcribing", forKey: "state")
                                }
                                WidgetCenter.shared.reloadAllTimelines()

                                player.seek(to: .zero)
                                player.play()
                                speechRecognizer.reset()
                                speechRecognizer.transcribe()
                            }
                            else{
                                simpleBigHaptic()
                                if let userDefaults = UserDefaults(suiteName: "group.com.tfp.beaware") {
                                    userDefaults.setValue("stopped", forKey: "state")
                                }
                                WidgetCenter.shared.reloadAllTimelines()

                                speechRecognizer.stopTranscribing()
                                print(speechRecognizer.transcript)
                            }
                        }})
                    {
                        if !isRecording{
                            ZStack{
                                Image(systemName: "mic.circle").resizable().scaledToFit()
                                    .frame(width: 50, height: 50)
//                                    .foregroundColor(Color(hex: 0x6bd45f ))
                                    .foregroundColor(Color("SecondaryColor"))
                                    .accessibilityHidden(true)
                                
                                Image(systemName: "record.circle.fill").resizable().scaledToFit()
                                    .frame(width: 132, height: 132)
//                                    .foregroundColor(Color(hex: 0x6bd45f))
                                    .foregroundColor(Color("SecondaryColor"))
                                    .accessibilityLabel("Start Transcribing")
                                
                            }.shadow(color: .black, radius: 5, x: 0, y: 4)

                        }
                        else
                        {
                            Image(systemName: "stop.circle.fill").resizable().scaledToFit()
                                .frame(width: 132, height: 132)
                                .foregroundColor(Color(hex: 0xea333c))
                                .shadow(color: .black, radius: 5, x: 0, y: 4)
                                .accessibilityLabel("Stop Transcribing")
                        }
                    }
                    TextEditor(
                        text: $speechRecognizer.transcript
                    ).accessibilityHint("This field populates in real time when the voice is being recorded")
                        .font(.custom("Avenir", size: 16))
                        .cornerRadius(10)
                        .border(Color("SecondaryColor"), width: 1)
                        .padding(.init(top: 12, leading: 25, bottom: 10, trailing: 25))
                }
            }
            .navigationTitle("SPEECH").navigationBarTitleDisplayMode(.inline)
            .navigationBarTitleTextColor(Color("SecondaryColor"))                            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink(
                        destination: SettingsView()
                    ) {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(Color("SecondaryColor"))
                    }
                    
                }
            }
        }// clsoing bracket for navigation view
//        .onAppear {
//            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation") // Forcing the rotation to portrait
//            AppDelegate.orientationLock = .portrait // And making sure it stays that way
//        }
//        .onDisappear {
//            AppDelegate.orientationLock = .all // Unlocking the rotation when leaving the view
//        }
        // Added this to dismiss the keyboard when tapping anywhere else on the page
        .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        // Added this to fix iPad navigation issue
        .navigationViewStyle(StackNavigationViewStyle())
    }
 //closing bracket for vard body some view
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            print("Available")
        } else {
            print("Available")
        }
    }
}
struct SpeechView_Previews : PreviewProvider {
    static var previews: some View {
        SpeechView()
    }
}

func simpleSuccessHaptic() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
}

func simpleEndHaptic() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.warning)
}

func simpleBigHaptic() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.error)
}
