//
//  ContentView.swift
//  FunVibeApp
//
//  Created by Apprenant 84 on 12/10/25.
//

import SwiftUI

struct HomeView: View {
    var userLoginStatus: Bool = UserDefaults.standard.bool(forKey: "isLoggedIn")

    var body: some View {
        ZStack {

            TabView {

                ExploreView()
                    .tabItem {
                        Label("", systemImage: "house")
                    }

                SearchView()
                    .tabItem {
                        Label("", systemImage: "magnifyingglass")
                    }

                if (userLoginStatus){
                    ProfileView()
                        .tabItem {
                            Label("", systemImage: "person.circle")
                        }
                } else {
                    UserLoginView()
                        .tabItem {
                            Label("", systemImage: "person.fill")
                        }
                }

            }
        }
        .ignoresSafeArea(edges: .all)
    }
}

#Preview {
    HomeView()
}
