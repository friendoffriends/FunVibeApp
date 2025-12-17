//
//  ProfileView.swift
//  FunVibe
//
//  Created by Apprenant 78 on 10/12/2025.
//

import SwiftUI

struct ProfileView: View {
    //@State var user: User?

    var body: some View {
        NavigationStack {
            ZStack {
                //Backgroound
                Image("Background")
                    .resizable()
                    .opacity(0.5)
                    .ignoresSafeArea(edges: .all)

                //Content
                if UserDefaults.standard.bool(forKey: "isLoggedIn") == false {
                    NavigationLink(destination: UserLoginView()){
                        Text("Please login to access this page")
                    }
                } else {
                    VStack {

                        let userMailId: String = UserDefaults.standard.string(forKey: "userRef") ?? ""
                        let user = findUser(email: userMailId)

                        Text("\(user?.fullName ?? "")")
                            .font(.largeTitle)
                            .padding()

                        Section(header: Text("Activités organisées").bold()) {
                            List (funvibes) { activity in
                                if (activity.organiser.email == user?.email) {
                                    Text(activity.title)

                                    }
                                }
                            }

                        Section(header: Text("Activités auxquelles participé").bold()) {
                            List (funvibes) { activity in
                                List(activity.participants ?? []) { participant in
                                    if (participant.email == user?.email) {
                                        Text(activity.title)
                                    }
                                }

                                }
                            }
                        }







//                            NavigationLink {
//                                //
//                            } label: {
//                                HStack {
//
//
//                                    VStack(alignment: .leading){
//                                        Text(activity.title)
//                                            .font(Font.headline.bold())
//
//                                        HStack{
//                                            Spacer()
//                                            Text(dateFormat(date: activity.date)).italic()
//                                            Spacer()
//                                            Text(timeFormat(date: activity.date)).italic()
//                                            Spacer()
//                                            //Text(activity.category.rawValue.capitalized)
//                                            //  .font(Font.caption).italic()
//                                        }
//                                        HStack{
//                                            Image(systemName: "person.2.fill")
//                                            Text("Participants : ")
//                                                .font(Font.subheadline).italic()
//                                            //Text(activity.participants.count)
//                                        }
//                                    }
//                                    .padding(20)
//                                }
//                                .foregroundColor(.orange)
//                                .background(
//                                    Color.white
//                                        .cornerRadius(10)
//                                        .padding(5)
//                                        .shadow(
//                                            color: .black.opacity(0.3),
//                                            radius: 10,
//                                            x:0, y:10
//                                        )
//                                )
//                            }



                    }
                }
            
            //.ignoresSafeArea(edges: .all)
            .navigationBarTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: UserLoginView()) {
                        Image(systemName: "person.slash")
                            .font(Font.title.bold()).foregroundColor(.orange)
                    }.simultaneousGesture(TapGesture().onEnded {
                        setLogout()
                    })
                }
//                ToolbarItem(placement: .navigationBarLeading) {
//                    NavigationLink(destination: ) {
//                        Image(systemName: "")
//                            .font(Font.title.bold()).foregroundColor(.orange)
//                    }
//
//                }
            }

        }

    }
}

#Preview {
    ProfileView()
}
