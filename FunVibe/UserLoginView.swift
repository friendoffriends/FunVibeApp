//
//  UserLoginView.swift
//  FunVibe
//
//  Created by Apprenant 78 on 11/12/2025.
//

import SwiftUI

struct UserLoginView: View {

    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @AppStorage("isAdmin") private var isAdmin: Bool = false
    @State private var username = ""
    @State private var password = ""
    //@State private var isAdmin: Bool = false

    var body: some View {
        NavigationStack {

            ZStack {
                //Backgroound
                Image("Background")
                    .resizable()
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.all)

                //if UserDefaults.standard.bool(forKey: "isLoggedIn")==true {
                if isLoggedIn {
                        if isAdmin==true {
                            NavigationLink(destination: AdminView()) {
                                Text("Continue to Admin profile")
                            }
                        } else {
                            NavigationLink(destination: ProfileView()) {
                                Text("Continue to your profile")
                            }
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

                        }.disabled(username.isEmpty || password.isEmpty)
                            .padding()
                            .buttonStyle(PlainButtonStyle())
                            .frame(maxWidth: 150, maxHeight: 40)
                            .background(Color(.systemGray6))
                            .cornerRadius(20)

                        .padding(.bottom, 50)

                        NavigationLink(
                            destination: CreateUserView()) {
                                Text("Créer un compte")
                            }
                    }
                    .navigationTitle(Text("Login"))
                }
            }
        }
    }

    private func authenticateUser() {
        if findUser(email: username) != nil {
            if findUserPassword(email: username, password: password) ?? false{
                isLoggedIn = true
                $username.wrappedValue = ""
                $password.wrappedValue = ""
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                UserDefaults.standard.set(false, forKey: "isAdmin")
            }
            else{
                print("Invalid credentials")
            }
        }
        else if username == "admin" && password == "password" {
            isLoggedIn = true
            $username.wrappedValue = ""
            $password.wrappedValue = ""
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            UserDefaults.standard.set(true, forKey: "isAdmin")
        }
        else {
            print("Invalid credentials")
        }
    }
}

#Preview {
    UserLoginView()
}
