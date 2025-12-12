//
//  MicrophoneView.swift
//  FunVibe
//
//  Created by asma taberkokt on 11/12/2025.
//

import SwiftUI
import Speech
struct MicrophoneView: View {
    @State private var fillLevel : CGFloat = 0.0
    @State private var isRecording: Bool = false
    @State private var transcript: String = ""
    
    
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
                Text(transcript)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                /*  Button(action: addItem) {
                 Label("Add Folder", systemImage: "folder.badge.plus")
                 }*/
                    //Mic
                MicObjView(fillLevelBinding: $fillLevel)
                    .padding(.top)
                Text("Parlez")
                .font(.title)}
            
        }
        
    }
}

#Preview {
    MicrophoneView()
}
