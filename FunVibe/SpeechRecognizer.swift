//
//  SpeechRecognizer.swift
//  Scrumdinger
//
//  Created by Ahmad Dorra on 2/11/21.
//
// Add "Privacy - Microphone Usage Description"
//     "Privacy - Speech Recognition Usage Description"
// to info.plist
//

import Foundation
import SwiftUI
import AVFoundation
import Speech

/// A helper for transcribing speech to text using AVAudioEngine.
struct SpeechRecognizer {
    private class SpeechAssist {
        var audioEngine: AVAudioEngine?
        var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
        var recognitionTask: SFSpeechRecognitionTask?
        let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "fr-Fr"))

        deinit {
            reset()
        }

        func reset() {
            recognitionTask?.cancel()
            audioEngine?.stop()
            audioEngine = nil
            recognitionRequest = nil
            recognitionTask = nil
        }
    }

    private let assistant = SpeechAssist()

    /**
     Begin transcribing audio.

     Creates a `SFSpeechRecognitionTask` that transcribes speech to text until you call `stopRecording()`.
     The resulting transcription is continuously written to the provided text binding.

     -  Parameters:
     - speech: A binding to a string where the transcription is written.
     */
    func record(to speech: Binding<String>) {
        relay(speech, message: "Demande d'accés ")
        canAccess { authorized in
            guard authorized else {
                relay(speech, message: "Accées refusé")
                return
            }

            relay(speech, message: "Accés garantie")

            assistant.audioEngine = AVAudioEngine()
            guard let audioEngine = assistant.audioEngine else {
                fatalError("Impossible de créer le moteur audio")
            }
            assistant.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            guard let recognitionRequest = assistant.recognitionRequest else {
                fatalError("Impossible de créer la demande")
            }
            recognitionRequest.shouldReportPartialResults = true

            do {
                relay(speech, message: "Démarrage de système audio")

                let audioSession = AVAudioSession.sharedInstance()
                try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
                try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
                let inputNode = audioEngine.inputNode
                relay(speech, message: "Found input node")

                let recordingFormat = inputNode.outputFormat(forBus: 0)
                inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
                    recognitionRequest.append(buffer)
                }
                relay(speech, message: "En cours..")
                audioEngine.prepare()
                try audioEngine.start()
                assistant.recognitionTask = assistant.speechRecognizer?.recognitionTask(with: recognitionRequest) { (result, error) in
                    var isFinal = false
                    if let result = result {
                        relay(speech, message: result.bestTranscription.formattedString)
                        isFinal = result.isFinal
                    }

                    if error != nil || isFinal {
                        audioEngine.stop()
                        inputNode.removeTap(onBus: 0)
                        self.assistant.recognitionRequest = nil
                    }
                }
            } catch {
                print("Erreur de transcription  audio: " + error.localizedDescription)
                assistant.reset()
            }
        }
    }

    /// Stop transcribing audio.
    func stopRecording() {
        assistant.reset()
    }

    private func canAccess(withHandler handler: @escaping (Bool) -> Void) {
        SFSpeechRecognizer.requestAuthorization { status in
            if status == .authorized {
                AVAudioApplication.requestRecordPermission { authorized in
                    handler(authorized)
                }
            } else {
                handler(false)
            }
        }
    }

    private func relay(_ binding: Binding<String>, message: String) {
        DispatchQueue.main.async {
            binding.wrappedValue = message
        }
    }
}

