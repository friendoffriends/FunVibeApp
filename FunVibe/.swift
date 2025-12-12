//
//  SpeechView.swift
//  voiceTest
//
//  Created by asma taberkokt on 12/12/2025.
//

/*import SwiftUI
import MediaPlayer
import AVFoundation
import Speech

struct SpeechView: View {
    @State var textValue: String = "Press start to record speech..."
    @State var speechRecognizer = SpeechRecognizer()
    
    @State private var spokenText: String = ""
    @State private var isRecording: Bool = false
    
    var body: some View {
        VStack(spacing: 50) {
            Image(systemName: isRecording ? "mic.fill" : "mic")
                .imageScale(.large)
                .scaleEffect(2.0)
                .foregroundColor(isRecording ? .accentColor : .primary)
            Text(isRecording ? textValue : "Appuez sur Start pour parler...")
            if !isRecording {
                Button {
                    print("starting speech recognition")
                    self.textValue = ""
                    self.spokenText = ""
                    isRecording = true
                    speechRecognizer.record(to: $textValue)
                } label: {
                    Text("Start")
                }
            } else {
                Button {
                    print("stopping speech recognition")
                    isRecording = false
                    spokenText = textValue
                    speechRecognizer.stopRecording()
                    textValue = "Appuyez sur Start pour parler..."
                    print(spokenText)
                } label: {
                    Text("Stop")
                }
            }
            if !isRecording {
                Text(spokenText)
            }
        }
        .padding()
    }
}

#Preview {
    SpeechView()
}*/

import SwiftUI
import MediaPlayer
import AVFoundation
import Speech

struct SpeechView: View {
    @State private var fillLevel : CGFloat = 0.0
    @State var textValue: String = "Press start to record speech..."
    @State var speechRecognizer = SpeechRecognizer()
    
    @State private var spokenText: String = ""
    @State private var isRecording: Bool = false
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [
                    .white,
                    .orange.opacity(0.1),
                    .orange.opacity(0.4)
                ]),
                center: .center,
                startRadius: 50,
                endRadius: 400
            )
            .ignoresSafeArea()
            
            VStack {
                Text("Qu’aimez-vous faire ?")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                MicObjView(fillLevelBinding: $fillLevel)
                    .padding(.top)
                
                Text(isRecording ? textValue : "Parlez")
                    .font(.title)
                    .padding(.bottom, 20)
                
                if !isRecording {
                    Button {
                        print("starting speech recognition")
                        self.textValue = ""
                        self.spokenText = ""
                        isRecording = true
                        speechRecognizer.record(to: $textValue)
                    } label: {
                        Text("Start")
                            .font(.title2)
                    }
                } else {
                    Button {
                        print("stopping speech recognition")
                        isRecording = false
                        spokenText = textValue
                        speechRecognizer.stopRecording()
                        textValue = "Appuyez sur Start pour parler..."
                        print(spokenText)
                    } label: {
                        Text("Stop")
                            .font(.title2)
                    }
                }
                
                if !isRecording {
                    Text(spokenText)
                        .padding(.top, 10)
                }
            }
        }
    }
}

#Preview {
    SpeechView()
}

