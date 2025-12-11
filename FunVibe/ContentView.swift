//
//  ContentView.swift
//  FunVibeApp
//
//  Created by Apprenant 84 on 12/10/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {

            TabView {

                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }

            }
        }
        .ignoresSafeArea(edges: .all)
    }
}

#Preview {
    ContentView()
}
