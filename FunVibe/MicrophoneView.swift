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
    @State var textValue: String = "Appuez start pour commencer..."
    @State var speechRecognizer = SpeechRecognizer()
    
    @State private var spokenText: String = ""
    @State private var isRecording: Bool = false
    
    
    var body: some View {
        NavigationStack{
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
                            print("comencement de l'utilisation de microphone ")
                            self.textValue = ""
                            self.spokenText = ""
                            isRecording = true
                            speechRecognizer.record(to: $textValue)
                        } label: {
                            Text("Appuez içi pour enregistrer")
                                .foregroundColor(.black)
                                .padding()
                        }
                    } else {
                        Button {
                            print("Arret d'utilisation de microphone")
                            isRecording = false
                            spokenText = textValue
                            speechRecognizer.stopRecording()
                            textValue = "Appuyez next pour terminer .."
                            print(spokenText)
                        } label: {
                            Text("Arretez l'enregistrement")
                                .foregroundColor(.black)
                            
                        }.padding(10)
                    }
                    if !isRecording {
                        Text(spokenText)
                            .padding(10)
                        NavigationLink(
                            "Allez",
                            destination: HomeView(
                                searchTextVar: spokenText
                            ).font(.title)
                        )
                    }
                }
                
                
                
            }

        }
            
        }
        
    }


#Preview {
    MicrophoneView()
}
