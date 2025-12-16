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
                        TextField("Nom d'utilisateur", text: $username)
                            .frame(width: 300, )

                            .font(.title2)
                            .padding(.trailing, 30)
                            .padding()
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.orange, lineWidth: 2))
                            .cornerRadius(12)
                        SecureField("Mot de passe", text: $password)
                            .frame(width: 330, )
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .font(.title2)
                            .padding()
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.orange, lineWidth: 2))
                            .cornerRadius(12)
                        Button("Login") {
                            authenticateUser()

                        }.disabled(username.isEmpty || password.isEmpty)
                            .padding()
                            .buttonStyle(PlainButtonStyle())
                            .frame(maxWidth: 150, maxHeight: 60)
                            .background(Color(.systemGray6))
                            .cornerRadius(20)

                        .padding(.bottom, 50)

                        NavigationLink(destination: CreateUserView()) {
                            Text("Créer un compte")
                                .font(.title2)
                                .foregroundColor(.white)
                                .frame(maxWidth: 160)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
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
