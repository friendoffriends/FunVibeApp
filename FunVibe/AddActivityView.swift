//
//  AddActivityView.swift
//  FunVibe
//
//  Created by Apprenant 78 on 16/12/2025.
//

import SwiftUI

struct AddActivityView: View {

    @State private var activityType : String = ""


    var body: some View {
        NavigationStack {

            ZStack {
                //Backgroound
                Image("Background")
                    .resizable()
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.all)

                //Content
                VStack{
                    NavigationLink(destination: {
                        AddEventView()
                    }, label: {
                        Text("Événements")
                            .font(.title2).bold()
                            .foregroundColor(.white)
                            .frame(maxWidth: 180)
                            .padding()
                            .background(Color.orange.opacity(0.8))
                            .cornerRadius(10)
                    })
                    .padding(30)
                    NavigationLink(destination: {
                        AddClubView()
                    }, label: {
                        Text("Un club")
                            .font(.title2).bold()
                            .foregroundColor(.white)
                            .frame(maxWidth: 180)
                            .padding()
                            .background(Color.orange.opacity(0.8))
                            .cornerRadius(10)
                    })
                    .padding(30)
                    NavigationLink(destination: {
                        AddHobbyView()
                    }, label: {
                        Text("Un intérêt")
                            .font(.title2).bold()
                            .foregroundColor(.white)
                            .frame(maxWidth: 180)
                            .padding()
                            .background(Color.orange.opacity(0.8))
                            .cornerRadius(10)
                    })
                    .padding(30)
                    Spacer()

                }
                .padding(30)
                .navigationTitle(Text("Choose an Activity"))
            }
        }
    }
}

#Preview {
    AddActivityView()
}
