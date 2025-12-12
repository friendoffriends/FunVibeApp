//
//  ProfileView.swift
//  FunVibe
//
//  Created by Apprenant 78 on 10/12/2025.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                //Backgroound
                Image("Background")
                    .resizable()
                    .opacity(0.5)

                //Content
                if UserDefaults.standard.bool(forKey: "isLoggedIn") == false {
                    NavigationLink(destination: UserLoginView()){
                        Text("Please login to access this page")
                    }
                } else {
                    VStack {
                        Text("Profile")
                            .font(.largeTitle)
                            .foregroundColor(.primary)

                            .padding(20)

                        NavigationLink(destination: ExploreView()) {
                            Image(systemName: "person.slash")
                                .font(Font.title.bold()).foregroundColor(.orange)
                        }.simultaneousGesture(TapGesture().onEnded {
                            setLogout()
                        })
                    }
                }


            }
            .ignoresSafeArea(edges: .all)
            .navigationBarTitle("Profile")

        }

    }

    func setLogout() -> Void {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
    }
}

#Preview {
    ProfileView()
}
