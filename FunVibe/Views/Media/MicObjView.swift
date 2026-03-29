//
//  MicObjView.swift
//  FunVibe
//
//  Created by asma taberkokt on 11/12/2025.
//

import SwiftUI

struct MicObjView: View {
    @Binding var fillLevelBinding : CGFloat
        //@State private var isRecording: Bool = false
    
    var body: some View {
            // Implmentation de MIC Objet
        ZStack {
            /*  Button(action: addItem) {
             Label("Add Folder", systemImage: "folder.badge.plus")
             }*/
            Circle()
            
                .fill(
                    RadialGradient(
                        gradient: Gradient(
                            colors: [ .white,.orange.opacity(0.2),.orange.opacity(0.1)]
                        ),
                        center: .center,
                        startRadius: 200,
                        endRadius: 100
                    )
                )
                .frame(width: 300, height: 300)
            VStack {
                Image(systemName: "microphone.fill")
                    .resizable()
                    .frame(width: 100, height: 140)
                    .symbolEffect(.scale)
                    .foregroundColor(.black)
                    .mask(
                        Rectangle()
                            .frame(height: 150 * fillLevelBinding)
                            .alignmentGuide(.bottom) { d in d[.bottom] }
                            .offset(y: 150 * (1 - fillLevelBinding) / 2) // align from bottom
                    )
                
                
            }
            .onAppear() {
                
                withAnimation(
                    .easeInOut(duration: 0.7).repeatForever(autoreverses: true)
                ) {
                    self.fillLevelBinding = 1
                }
            }
        }
    }
}

#Preview {
    MicObjView(fillLevelBinding: Binding.constant(1.0))
}
