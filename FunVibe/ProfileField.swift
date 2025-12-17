//
//  ProfileField.swift
//  FunVibe
//
//  Created by asma taberkokt on 13/12/2025.
//

import SwiftUI

struct ProfileField: View {
    
    let icon: String
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
                
            Text(title)
                .font(.title)
            
            ZStack(alignment: .trailing) {
                TextField(placeholder, text: $text)
                    .font(.title)
                    .padding(.trailing, 30)
                    .padding()
                        .background(Color.white) 
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.orange, lineWidth: 2))
                    .cornerRadius(12)
                
                Image(systemName: icon)
                    .foregroundColor(.gray)
                    .padding(.trailing, 12)
            }
        }
    }
}

