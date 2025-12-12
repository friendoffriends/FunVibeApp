//
//  UserLoginView.swift
//  FunVibe
//
//  Created by Apprenant 78 on 11/12/2025.
//

import SwiftUI

struct UserLoginView: View {

    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @State private var username = ""
    @State private var password = ""

    var body: some View {
        NavigationStack {

            ZStack {
                //Backgroound
                Image("Background")
                    .resizable()
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.all)


                if isLoggedIn {
                //if UserDefaults.standard.bool(forKey: "isLoggedIn")==true {
                    NavigationLink(
                        destination: ProfileView()) {
                            Text("Continue to your profile")
                        }
                } else {
                    VStack {
                        TextField("Username", text: $username)
                            .frame(width: 300)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .padding()
                        SecureField("Password", text: $password)
                            .frame(width: 300)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .padding()
                        Button("Login") {
                            authenticateUser()
                        }
                        .padding(.bottom, 30)

                        NavigationLink(
                            destination: CreateUserView()) {
                                Text("Continue to your profile")
                            }
                    }
                    .navigationTitle(Text("Login"))
                }
            }
        }

    }

    private func authenticateUser() {
        if username == "admin" && password == "password" {
            isLoggedIn = true
            $username.wrappedValue = ""
            $password.wrappedValue = ""
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
        }
    }
}

#Preview {
    UserLoginView()
}
