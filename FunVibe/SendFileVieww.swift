//
//  SendFileVieww.swift
//  FunVibe
//
//  Created by asma taberkokt on 15/12/2025.
//

import SwiftUI

struct SendFileView: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("📤 Envoyer un fichier")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("Ici, vous pourrez sélectionner un fichier ou une image à envoyer pour votre activité.")
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding()
            
            Button("Retour") {
                    // Normally you would handle dismiss or navigation back
            }
            .font(.title2)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(15)
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SendFileView()
}
