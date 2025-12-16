//
//  IndividualEventView.swift
//  FunVibe
//
//  Created by Apprenant 84 on 12/16/25.
//

// Chris to finish the View 16-12-25 

/*

import Foundation
import SwiftUI

struct IndividualEventView(Activity individualEvent): View {
//    @State var searchText: String = ""
    var body: some View {
        ZStack {
            //Backgroound
            Image("Background")
                .resizable()
                .opacity(0.5)

            //Content
            NavigationStack {
                ScrollView(.vertical){
                    VStack (alignment:.leading){
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 200)
                            .foregroundColor(.orange.opacity(0.5))
                            .padding(5)
                            .shadow(color: .blue.opacity(0.3), radius: 10,x: 0,y: 5)

//                        ForEach (funvibes) { activity in
//                            NavigationLink {
//                                //
//                            } label: {
                                HStack {
                                    if individualEvent.image == "" {
                                        Image(systemName: "photo.fill")
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
                                            .shadow(radius: 10)
                                            .padding(.leading)
                                    }
                                    else{
                                        Image(individualEvent.image!)
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
                                            .shadow(radius: 10)
                                            .padding(.leading)
                                    }

                                    VStack(alignment: .leading){
                                        Text(individualEvent.title)
                                            .font(Font.headline.bold())
                                        Text(individualEvent.description)
                                            .font(.subheadline)
                                            .multilineTextAlignment(.leading)
                                            .lineLimit(2)
                                        HStack{
                                            Spacer()
                                            Text(dateFormat(date: individualEvent.date)).italic()
                                            Spacer()
                                            Text(timeFormat(date: individualEvent.date)).italic()
                                            Spacer()
                                            //Text(individualEvent.category.rawValue.capitalized)
                                              //  .font(Font.caption).italic()
                                        }
                                        Text("Participants : ")
                                            .font(Font.caption).italic()
                                        //Text(individualEvent.participants.count)

                                    }
                                    .padding(20)
//                                }
                                .foregroundColor(.orange)
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
                        NavigationLink(destination: AddindividualEventView()) {
                                Image(systemName: "plus.circle")
                                .font(Font.title.bold()).foregroundColor(.orange)
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink(destination: MapView()) {
                            Image(systemName: "map.circle")
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
    IndividualEventView()
}
/*
