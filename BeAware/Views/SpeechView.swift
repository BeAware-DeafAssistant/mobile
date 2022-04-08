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
    @State private var isRecording = false
    @State private var permissionStatus = SFSpeechRecognizerAuthorizationStatus.notDetermined
    @State private var errorMessage = "For this functionality to work, you need to provide permission in your settings"
    @State private var transcription = ""
    @State private var task: SFSpeechRecognitionTask? = SFSpeechRecognitionTask()
    @State private var audioEngine = AVAudioEngine()
    @State private var request = SFSpeechAudioBufferRecognitionRequest()
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
                                startSpeechRecognization()
                            }
                            else{
                                simpleBigHaptic()
                                if let userDefaults = UserDefaults(suiteName: "group.com.tfp.beaware") {
                                    userDefaults.setValue("stopped", forKey: "state")
                                }
                                WidgetCenter.shared.reloadAllTimelines()
                                cancelSpeechRecognization()
                            }
                        }})
                    {
                        if !isRecording{
                            ZStack{
                                Image(systemName: "mic.circle").resizable().scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(Color("SecondaryColor"))
                                    .accessibilityHidden(true)
                                
                                Image(systemName: "record.circle.fill").resizable().scaledToFit()
                                    .frame(width: 132, height: 132)
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
                    if (permissionStatus != SFSpeechRecognizerAuthorizationStatus.authorized)
                    {
                        Text(errorMessage)
                            .font(Font.custom("Avenir", size: 16))
                            .padding()
                            .foregroundColor(Color("SecondaryColor"))
                    }
                    TextEditor(
                        text: $transcription
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
        .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        .onAppear{requestPermission()}
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
    
    func requestPermission()  {
        SFSpeechRecognizer.requestAuthorization { (authState) in
            OperationQueue.main.addOperation {
                if authState == .authorized {
                    permissionStatus = .authorized
                } else if authState == .denied {
                    permissionStatus = .denied
                } else if authState == .notDetermined {
                    permissionStatus = .notDetermined
                } else if authState == .restricted {
                    permissionStatus = .restricted
                }
            }
        }
    }
    
    func startSpeechRecognization(){
        let node = audioEngine.inputNode
        let recordingFormat = node.outputFormat(forBus: 0)
        
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            request.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch let error {
            errorMessage = "Error comes here for starting the audio listner =\(error.localizedDescription)"
        }
        
        guard let myRecognization = SFSpeechRecognizer() else {
            errorMessage = "Recognization is not allow on your local"
            return
        }
        
        print(myRecognization.isAvailable)
        if !myRecognization.isAvailable {
            errorMessage = "Recognization is not free right now, Please try again after some time."
        }
        
        task = myRecognization.recognitionTask(with: request) { (response, error) in
            guard let response = response else {
                if error != nil {
                    errorMessage = error?.localizedDescription ?? "For this functionality to work, you need to provide permission in your settings"
                }else {
                    errorMessage = "Problem in giving the response"
                }
                return
            }
            let message = response.bestTranscription.formattedString
            transcription = message
        }
    }
    
    func cancelSpeechRecognization() {
        task?.finish()
        task?.cancel()
        task = nil
        
        request.endAudio()
        audioEngine.stop()
        
        //MARK: UPDATED
        if audioEngine.inputNode.numberOfInputs > 0 {
            audioEngine.inputNode.removeTap(onBus: 0)
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
