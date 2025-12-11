//
//  HomeView.swift
//  FunVibe
//
//  Created by Apprenant 78 on 10/12/2025.
//

import SwiftUI

struct HomeView: View {
    @State var searchText: String = ""

    var body: some View {
        ZStack {
            //Backgroound
            Image("Background")
                .resizable()
                .opacity(0.5)

            //Content
            NavigationStack {
                ScrollView(.vertical){
                    VStack{
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 200)
                            .foregroundColor(.orange.opacity(0.5))
                            .padding(5)
                            .shadow(color: .blue.opacity(0.3), radius: 10,x: 0,y: 5)
                            //.shadow(color: .black.opacity(0.5),radius: 5,x:0, y:10)

                        ForEach(clubs) { club in
                            NavigationLink {
                                //
                            } label: {
                                HStack{
                                    if club.image == "" {
                                        Image(systemName: "photo.fill")
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
                                            .shadow(radius: 10)
                                            .padding(.leading)
                                    }else{
                                        Image(club.image!)
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
                                            .shadow(radius: 10)
                                            .padding(.leading)
                                    }
                                    VStack(alignment: .leading){
                                        Text(club.title)
                                            .font(Font.headline.bold())
                                        Text(club.description)
                                            .font(.subheadline)
                                            .multilineTextAlignment(.leading)
                                            .lineLimit(2)
                                        //Text("\(club.date.formatted(.dateTime))")
                                        HStack{
                                            Text(dateFormat(date: club.date))
                                            Spacer()
                                            Text(club.category.rawValue.capitalized)
                                                .font(Font.caption).italic()
                                        }
                                    }
                                    .padding(20)
                                }
                                .background(
                                    Color.white
                                        .cornerRadius(10)
                                        .padding(5)
                                        .shadow(
                                            color: .black.opacity(0.3),
                                            radius: 10,
                                            x:0, y:10
                                        )
                                )
                            }
                        }
                    }
                    
                }
                
                .padding(5)
                .navigationTitle(Text("Activités"))
                .searchable(text: $searchText)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: AddActivityView()) {
                                Image(systemName: "plus.circle")
                                .font(Font.title.bold()).foregroundColor(.orange)

                        }

                    }
                }

            }
        }
        .ignoresSafeArea(edges: .all)

    }
}

#Preview {
    HomeView(searchText: "")
}
