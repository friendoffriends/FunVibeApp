//
//  AdminView.swift
//  FunVibe
//
//  Created by Apprenant 78 on 15/12/2025.
//

import SwiftUI

struct AdminView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                //Backgroound
                //Image("Background")
                Color.clear
                //.resizable()
                    .opacity(0.5)
                    .ignoresSafeArea(edges: .all)

                //Content
                // ScrollView(.vertical){
                VStack(alignment: .center, spacing: 20) {
                    Text("Admin Panel")
                        .font(.title).bold()

                    Section(header: Text("FunVibes").bold()) {
                        List(funvibes) { funvibe in
                            HStack {
                                Text(funvibe.title)
                                Spacer()
                                Image(systemName: "minus.circle")

                            }

                        }
                    }

                    Section(header: Text("Users").bold()) {
                        List(users) { user in
                            HStack {
                                Text(user.fullName).bold()
                                Text(user.email)
                                Spacer()
                                Image(systemName: "minus.circle")
                            }

                        }
                    }

                    Section(header: Text("Addresses").bold()) {
                        List(addresses) { address in
                            HStack {
                                Text(address.street ?? "")
                                Text(address.city ?? "")
                                Text(address.postCode ?? "")
                                Spacer()
                                Image(systemName: "minus.circle")
                            }
                        }
                    }


                    NavigationLink(destination: UserLoginView()) {
                        Image(systemName: "person.slash")
                            .font(Font.title.bold()).foregroundColor(.orange)
                    }.simultaneousGesture(TapGesture().onEnded {
                        setLogout()
                    })

                    }
                //}
            }
        }
        .navigationTitle(Text("Admin"))
    }
}

#Preview {
    AdminView()
}
