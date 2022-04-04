//
//  SpeechRecognizer.swift
//  BeAware
//
//  Created by Saamer Mansoor on 2/11/22.
//

import AVFoundation
import Foundation
import Speech
import SwiftUI

/// A helper for transcribing speech to text using SFSpeechRecognizer and AVAudioEngine.
class SpeechRecognizer: ObservableObject {
    enum RecognizerError: Error {
        case nilRecognizer
        case notAuthorizedToRecognize
        case notPermittedToRecord
        case recognizerIsUnavailable
        
        var message: String {
            switch self {
            case .nilRecognizer: return "Can't initialize speech recognizer"
            case .notAuthorizedToRecognize: return "Not authorized to recognize speech"
            case .notPermittedToRecord: return "Not permitted to record audio"
            case .recognizerIsUnavailable: return "Recognizer is unavailable"
            }
        }
    }
    
    @Published var transcript: String = ""
    
    private var audioEngine: AVAudioEngine?
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?
    private let recognizer: SFSpeechRecognizer?
    
    /**
     Initializes a new speech recognizer. If this is the first time you've used the class, it
     requests access to the speech recognizer and the microphone.
     */
    init() {
        print(Locale.current)
        print(Locale.preferredLanguages[0])
        print(Locale(identifier: Locale.preferredLanguages[0]))
        print(NSLocale.current)

        recognizer = SFSpeechRecognizer(locale: Locale(identifier: Locale.preferredLanguages[0]))
        
        Task(priority: .high) {
            do {
                print("10A")
                guard recognizer != nil else {
                    print("11")
                    throw RecognizerError.nilRecognizer
                }
                guard await SFSpeechRecognizer.hasAuthorizationToRecognize() else {
                    print("12")
                    throw RecognizerError.notAuthorizedToRecognize
                }
                guard await AVAudioSession.sharedInstance().hasPermissionToRecord() else {
                    print("13")
                    throw RecognizerError.notPermittedToRecord
                }
            } catch {
                print("14")
                speakError(error)
            }
        }
    }
    
    deinit {
        reset()
    }
    
    /**
        Begin transcribing audio.
     
        Creates a `SFSpeechRecognitionTask` that transcribes speech to text until you call `stopTranscribing()`.
        The resulting transcription is continuously written to the published `transcript` property.
     */
    func transcribe() {
        print("15B")
        DispatchQueue(label: "Speech Recognizer Queue", qos: .background)
            .async { [weak self] in
            guard let self = self, let recognizer = self.recognizer, recognizer.isAvailable else {
                self?.speakError(RecognizerError.recognizerIsUnavailable)
                return
            }
            print("16C")
            do {
                print("17D-")

                let (audioEngine, request) = try Self.prepareEngine()
                print("17--")

                self.audioEngine = audioEngine
                print("17---")

                self.request = request
                print("17----")

                // Create a recognition task for the speech recognition session.
                // Keep a reference to the task so that it can be canceled.
                self.task = recognizer.recognitionTask(with: request) { result, error in
                    var isFinal = false
                    
                    if let result = result {
                        // Update the text view with the results.
//                        self.textView.text = result.bestTranscription.formattedString
                        isFinal = result.isFinal
//                        print(result.debugDescription.formatted(.))
                        self.transcript = result.bestTranscription.formattedString
                        print("Text \(result.bestTranscription.formattedString)")
                    }
                    
                    if error != nil || isFinal {
                        // Stop recognizing speech if there is a problem.
//                        self.audioEngine.stop()
//                        inputNode.removeTap(onBus: 0)
//
//                        self.recognitionRequest = nil
//                        self.recognitionTask = nil
//
//                        self.recordButton.isEnabled = true
//                        self.recordButton.setTitle("Start Recording", for: [])
                    }
                }

//                self.task = recognizer.recognitionTask(with: request, resultHandler: self.recognitionHandler(result:error:))
            } catch {
                print("19F")
                self.reset()

                self.speakError(error)
            }
        }
    }
    
    /// Stop transcribing audio.
    func stopTranscribing() {
        reset()
    }
    
    /// Reset the speech recognizer.
    func reset() {
        task?.cancel()
        audioEngine?.stop()
        audioEngine = nil
        request = nil
        task = nil
    }
    
    private static func prepareEngine() throws -> (AVAudioEngine, SFSpeechAudioBufferRecognitionRequest) {
        let audioEngine = AVAudioEngine()
        print("1E")
        let request = SFSpeechAudioBufferRecognitionRequest()
        print("2")
        request.shouldReportPartialResults = true
        print("2-")

        // Configure the audio session for the app.
        let audioSession = AVAudioSession.sharedInstance()
        print("2--")
        do{
            try audioSession.setCategory(.playAndRecord, mode: .voiceChat, options: .mixWithOthers)
            print("2---")
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        }
        catch let error as NSError {
            print("Unable to activate audio session:  \(error.localizedDescription)")
        }
        print("2----")
        let inputNode:AVAudioInputNode
        do{
            inputNode = audioEngine.inputNode
            print("2-----")
        }
        catch let error as NSError {
            print("Unable to activate audio session:  \(error.localizedDescription)")
            let utterance = AVSpeechUtterance(string: "")
            utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
            utterance.rate = 0.5
            let synthesizer = AVSpeechSynthesizer()        
            synthesizer.speak(utterance)
            inputNode = audioEngine.inputNode
        }
        // Configure the microphone input.
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            request.append(buffer)
        }
        audioEngine.prepare()
        
        try audioEngine.start()
        print("3")

        return (audioEngine, request)
    }
    
    private func recognitionHandler(result: SFSpeechRecognitionResult?, error: Error?) {
        let receivedFinalResult = result?.isFinal ?? false
        let receivedError = error != nil
        print("4")

        if receivedFinalResult || receivedError {
            audioEngine?.stop()
            audioEngine?.inputNode.removeTap(onBus: 0)
        }
        print("5")

        if let result = result {
            speak(result.bestTranscription.formattedString)
        }
    }
    
    private func speak(_ message: String) {
        transcript = message
    }
    
    private func speakError(_ error: Error) {
        var errorMessage = ""
        print("6")
        if let error = error as? RecognizerError {
            errorMessage += error.message
        } else {
            errorMessage += error.localizedDescription
        }
        print("7")
        transcript = "<< \(errorMessage) >>"
    }
}

extension SFSpeechRecognizer {
    static func hasAuthorizationToRecognize() async -> Bool {
        await withCheckedContinuation { continuation in
            requestAuthorization { status in
                continuation.resume(returning: status == .authorized)
            }
        }
    }
}

extension AVAudioSession {
    func hasPermissionToRecord() async -> Bool {
        await withCheckedContinuation { continuation in
            requestRecordPermission { authorized in
                continuation.resume(returning: authorized)
            }
        }
    }
}
