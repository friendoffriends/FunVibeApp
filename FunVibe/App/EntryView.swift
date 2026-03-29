//
//  EntryView.swift
//  FunVibe
//
//  Created by asma taberkokt on 11/12/2025.
//

import SwiftUI

struct EntryView: View {
    @State private var fillLevel: CGFloat = 0.0
    @State private var showInput = false
    @State private var text = ""
    @FocusState private var isFocused: Bool
    @State private var Navigate: Bool = false
    var body: some View {
        NavigationStack() {
            ZStack {
                    // Background
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
                
                    // Content
                VStack(spacing: 40) {
                    
                    Text("Qu’aimez-vous faire ?")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    
                    ZStack {
                        
                        ZStack {
                            Rectangle()
                                .fill(.white.opacity(0.6))
                                .frame(width: 300, height: 100)
                                .cornerRadius(15)
                                .shadow(color: .black.opacity(0.1), radius: 10)
                            
                            Text("Tapez içi pour écrire....")
                                .foregroundColor(.gray)
                        }
                        .opacity(showInput ? 0 : 1)   // hide button when input opens
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                showInput = true
                            }
                            isFocused = true
                        }
                        
                        if showInput {
                            TextField("Ecrivez içi...", text: $text)
                                .padding(20)
                                .frame(width: 350, height: 200)
                                .background(Color.gray.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .focused($isFocused)
                                .focused($isFocused)
                                .keyboardType(.emailAddress)
                                .transition(.scale.combined(with: .opacity))
                            
                            NavigationLink(
                                "Search", destination: ExploreView(searchText: "club")
                            )
                        }
                    }
                      
                    NavigationLink(destination: MicrophoneView()) {
                        
                        VStack {
                            ZStack {
                                Circle()
                                    .fill(
                                        RadialGradient(
                                            gradient: Gradient(colors: [
                                                .white,
                                                .orange.opacity(0.2),
                                                .orange.opacity(0.1)
                                            ]),
                                            center: .center,
                                            startRadius: 200,
                                            endRadius: 100
                                        )
                                    )
                                    .frame(width: 200, height: 200)
                                
                                
                                /*Button() {
                                 Navigate = true
                                 }
                                 */
                                
                                
                                
                                
                                Image(systemName: "microphone.fill")
                                    .resizable()
                                    .frame(width: 50, height: 80)
                                    .foregroundColor(.black)
                            }
                            
                            .opacity(showInput ? 0 : 1)        // hide the mic smoothly
                            .animation(.easeInOut, value: showInput)
                            .padding(.bottom, 40,)
                            Text("Appuyez pour parler")
                                .font(.title)
                                .foregroundColor(.black)
                                .opacity(showInput ? 0 : 1)
                                .animation(.easeInOut, value: showInput)
                        }
                    }
                }
                
            }
        }    }
}

#Preview {
    EntryView()
}
