//
//  MicrophoneView.swift
//  FunVibe
//
//  Created by asma taberkokt on 11/12/2025.
//

    //
    
    //
import SwiftUI
import MediaPlayer
import AVFoundation
import Speech

struct MicrophoneView: View {
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
                ]
                                   
                ),
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
                /*  Button(action: addItem) {
                 Label("Add Folder", systemImage: "folder.badge.plus")
                 }*/
                    //Mic
                MicObjView( fillLevelBinding: $fillLevel)
                    .padding(.top)
                Text(isRecording ? textValue: "Parlez")
                    .font(.title)
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
                        textValue = "Press start to record speech..."
                        print(spokenText)
                    } label: {
                        Text("Stop")
                    }
                }
                if !isRecording {
                    Text(spokenText)
                }
            }
                
                
                
            }
            
            
        }
        
    }


#Preview {
    MicrophoneView()
}
