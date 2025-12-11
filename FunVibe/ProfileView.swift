//
//  ProfileView.swift
//  FunVibe
//
//  Created by Apprenant 78 on 10/12/2025.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            //Backgroound
            Image("Background")
                .resizable()
                .opacity(0.5)

            //Content
            VStack {
                Text("Profile")
                    .font(.largeTitle)
                    .foregroundColor(.primary)
            }

        }
        .ignoresSafeArea(edges: .all)
    }
}

#Preview {
    ProfileView()
}
