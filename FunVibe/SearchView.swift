//
//  SearchView.swift
//  FunVibe
//
//  Created by Apprenant 78 on 10/12/2025.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        ZStack {
            //Backgroound
            Image("Background")
                .resizable()
                .opacity(0.5)

            //Content
            VStack {
                Text("Filter")
                    .font(.largeTitle)
                    .foregroundColor(.primary)
            }

        }
        .ignoresSafeArea(edges: .all)
    }
}

#Preview {
    SearchView()
}
