//
//  SpeechView.swift
//  BeAware
//
//  Created by Saamer Mansoor on 2/7/22.
//
import SwiftUI
import CoreHaptics
import AVFoundation
import AVFAudio

struct TextView : View {
    @State private var rotation = 0.0
    @State private var engine: CHHapticEngine?
    @State private var writtenText: String = ""
    @State private var newPreset: String = ""
    @AppStorage("TextFontSize") var fontSize = 50.0
    var placeholderString = "Tap here to start typing"
   
    @AppStorage("items") var data:[String] = ["Why was I pulled over?","I'm deaf/Hard of Hearing"]

    var body : some View {
        NavigationView{
            ZStack{
                Color("BrandColor")
                ScrollView{
                    VStack(alignment: .leading) {
                        if writtenText == ""{
                            HStack{
                                Text("Tap below to start typing:")
                                    .font(Font.custom("Avenir", size: 17))
                                    .foregroundColor(Color("SecondaryColor"))
                                Spacer()
                            }
                        }
                        TextEditor(
                            text: $writtenText
                        )
                            .frame(height: 300)
                            .minimumScaleFactor(0.5)
                            .font(.custom("Avenir", size: fontSize))
                            .lineLimit(5)
                            .layoutPriority(1)
                            .border(Color("SecondaryColor"), width: 1)
                            .rotationEffect(.degrees(rotation))
                        HStack{
                            Button(
                                action: {
                                    let utterance = AVSpeechUtterance(string: writtenText)
                                    utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
                                    utterance.voice = AVSpeechSynthesisVoice(language: AVSpeechSynthesisVoice.currentLanguageCode())
                                    utterance.rate = 0.5

                                    let synthesizer = AVSpeechSynthesizer()
                                    synthesizer.mixToTelephonyUplink = true
                                    synthesizer.speak(utterance)

                                }
                            ){
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10).frame(width: 80, height: 40).foregroundColor(Color("SecondaryColor")).shadow(color: .black, radius: 5, x: 0, y: 4)
                                    Text("PLAY").foregroundColor(Color("BrandColor"))
                                        .font(.custom("Avenir", size: 17))
                                        .accessibilityLabel("Play")
                                        .accessibilityHint("Play the the text loud, even to the other party during a call")
                                }
                            }
                            Button(
                                action: {
                                    if rotation == 0{
                                        rotation = 180
                                    }
                                    else {
                                        rotation = 0
                                    }
                                }
                            ){
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10).frame(width: 100, height: 40).foregroundColor(Color("SecondaryColor")).shadow(color: .black, radius: 5, x: 0, y: 4)
                                    Text("FLIP TEXT").foregroundColor(Color("BrandColor"))
                                        .font(.custom("Avenir", size: 17))
                                        .accessibilityLabel("flip screen")
                                        .accessibilityHint("Flips the screen for the other person to see what you typed")
                                }
                            }
                            Slider(value: $fontSize, in: 18...50, step: 4)
                            {
                                    Text("Speed")
                                } minimumValueLabel: {
                                    Text("A")
                                        .font(Font.custom("Avenir", size: 12))
                                        .foregroundColor(Color("SecondaryColor"))

                                } maximumValueLabel: {
                                    Text("A")
                                        .font(Font.custom("Avenir", size: 20))
                                        .foregroundColor(Color("SecondaryColor"))
                                }
                                .padding(.leading)
                        }
                        Text("Preset phrases:")
                            .font(Font.custom("Avenir", size: 24))
                            .fontWeight(.heavy)
                            .foregroundColor(Color("SecondaryColor"))
                        //-------
                        ForEach(data, id: \.self) { item in
                            //---
                            HStack{
                                Text("\(Image(systemName: "plus")) \(item)")
                                    .font(Font.custom("Avenir", size: 17))
                                    .foregroundColor(Color("SecondaryColor"))
                                    .lineLimit(1)
                                    .accessibilityAddTraits(.isButton)
                                    .accessibilityHint("Tap to add preset phrase to the text editor above")
                                    .onTapGesture(count: 1) {
                                        writtenText += " \(item)"
                                        complexSuccess()
                                    }
                                Spacer()
                                Image(systemName: "trash")
                                    .accessibilityLabel("Delete")
                                    .accessibilityHint("Removes the preset phrase")
                                    .accessibilityAddTraits(.isButton)
                                    .foregroundColor(Color("SecondaryColor"))
                                    .onTapGesture(count: 1) {
                                        print("Right on!")
                                        complexSuccess2()
                                        for (index,value) in data.enumerated(){
                                            if value == item{
                                                data.remove(at: index)
                                                return
                                                // TODO: Fix "Fatal error: Index out of range" when similar values
                                            }
                                        }
                                    }
                                
                            }
                            //---
                        }
                        //-------
                        HStack{
                            TextField("Type here...", text: $newPreset )
                                .frame(height: 50.0)
                                .accessibilityLabel("Input a preset phrase you would like to add")
                                .font(.custom("Avenir", size: 17))
                            Button(
                                action: {
                                    print("Hi")
                                    data.append(newPreset)
                                    complexSuccess3()
                                    newPreset=""
                                }
                            ){
                                ZStack{
                                    RoundedRectangle(cornerRadius: 10).frame(width: 80, height: 40).foregroundColor(Color("SecondaryColor")).shadow(color: .black, radius: 5, x: 0, y: 4)
                                    Text("ADD").foregroundColor(Color("BrandColor"))
                                        .font(.custom("Avenir", size: 17))
                                        .accessibilityLabel("Add")
                                        .accessibilityHint("Adds the phrase you input to a list of preset phrases")
                                }
                            }
                        }
                        Spacer()
                    }}
                .padding([.top, .leading, .trailing])
                .textFieldStyle(.roundedBorder)
                .navigationTitle("TEXT")
                .navigationBarTitleDisplayMode(.inline)
                .font(.custom("Avenir", size:17))
                .navigationBarTitleTextColor(Color("SecondaryColor"))
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        NavigationLink(
                            destination: SettingsView()
                        ) {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(Color("SecondaryColor"))
                        }
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: prepareHaptics)
        .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)

    }
    // Taken from here https://www.hackingwithswift.com/books/ios-swiftui/making-vibrations-with-uinotificationfeedbackgenerator-and-core-haptics

    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create one intense, sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    
    func complexSuccess2() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create one intense, sharp tap
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    
    func complexSuccess3() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create one intense, sharp tap
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}
struct TextView_Previews : PreviewProvider {
    static var previews: some View {
        TextView()
    }
}
