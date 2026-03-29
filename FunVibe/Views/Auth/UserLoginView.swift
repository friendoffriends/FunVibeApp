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
    @AppStorage("userRef") private var user: String = ""

    @State private var username = ""
    @State private var password = ""
    //@State private var isAdmin: Bool = false
    @State private var isError: Bool = false

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
                            NavigationLink(
                                destination: ProfileView()
                                )
                            {
                                //Text(username)
                                Text("Continue to your profile")
                            }
                        }

                } else {
                    VStack {
                        
                        
                        VStack(alignment:.leading){
                            Text("Nom d'utilisateur")
                                .font(.title)
                        TextField("Nom d'utilisateur", text: $username)
                            .frame(width: 300, )
                            .font(.title)
                            .padding(.trailing, 30)
                            .padding()
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.orange, lineWidth: 2))}
                            .cornerRadius(20)
                            .autocapitalization(.none)

                        PasswordField(
                            icon: "lock.fill",
                            title: "Mot de passe",
                            placeholder: "Mot de passe",
                            text: $password
                        )
                        .frame(width: 360, )
                        Button("Login") {
                            authenticateUser()

                        }
                        .disabled(username.isEmpty || password.isEmpty)
                        .alert("Vérifiez votre adresse e-mail \nou votre mot de passe.", isPresented: $isError, actions: {
                            Button("OK") {
                                //isError = false
                            }
                        })

                            .padding()
                            .buttonStyle(PlainButtonStyle())
                            .frame(maxWidth: 290, maxHeight: 60)
                            .background(Color(.systemGray6))
                            .cornerRadius(20)
                            .font(.title)
                            .padding(.top, 30 )
                            .padding(.bottom, 30 )



                        NavigationLink(destination: CreateUserView()) {
                            Text("Créer un compte")
                                .font(.title)
                                .foregroundColor(.white)
                                .frame(maxWidth: 260)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(20)
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
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                UserDefaults.standard.set(false, forKey: "isAdmin")
                UserDefaults.standard.set(username, forKey: "userRef")
                isLoggedIn = true
                $username.wrappedValue = ""
                $password.wrappedValue = ""
                isError = false
            }
            else{
                //print("Invalid credentials")
                isError = true
                $username.wrappedValue = ""
                $password.wrappedValue = ""
            }
        }
        else if username == "admin" && password == "password" {
            isLoggedIn = true
            $username.wrappedValue = ""
            $password.wrappedValue = ""
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            UserDefaults.standard.set(true, forKey: "isAdmin")
            isError = false
        }
        else {
            print("Invalid credentials")
            isError = true
            $username.wrappedValue = ""
            $password.wrappedValue = ""
        }
    }
}

#Preview {
    UserLoginView()
}
