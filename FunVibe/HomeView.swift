//
//  ContentView.swift
//  FunVibeApp
//
//  Created by Apprenant 84 on 12/10/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {

            TabView {

                ExploreView()
                    .tabItem {
                        Label("", systemImage: "house")
                    }

                ProfileView()
                    .tabItem {
                        Label("", systemImage: "person")
                    }

            }
        }
        .ignoresSafeArea(edges: .all)
    }
}

#Preview {
    HomeView()
}
