//
//  IndividualEventView.swift
//  FunVibe
//
//  Created by Apprenant 84 on 12/16/25.
//


import Foundation
import SwiftUI

struct IndividualEventView: View {
//    @State var searchText: String = ""
    @State var individualEvent: Activity
    var body: some View {
        ZStack {
            //Backgroound
            Image("Background")
                .resizable()
                .opacity(0.5)
                .ignoresSafeArea(edges: .all)

            //Content
            NavigationStack {
                ScrollView(.vertical){
                    VStack (alignment:.leading){
                        HStack{
                            Text(individualEvent.title).font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.orange)
                                .padding(.leading)
                            Spacer()
                            NavigationLink(destination: MapView(results: [individualEvent])) {
                                Image(systemName: "map.circle")
                                    .font(Font.largeTitle.bold()).foregroundColor(.orange)
                            }
                        }
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
                                .frame(height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(radius: 10)
                                .padding(5)
                        }
                        HStack{
                            Text(dateFormat(date: individualEvent.date)).italic()
                                .font(.system(size: 18))
                                .padding(5)
                                .padding(.leading, 10)
                            Text(timeFormat(date: individualEvent.date)).italic()
                                .font(.system(size: 18))
                                .padding(.leading, 10)
//                            Text(individualEvent.category.rawValue.capitalized)
                              //  .font(Font.caption).italic()
                            Text("Participants : ").italic()
                                    .font(.system(size: 18))
                                    .padding(.leading, 20)
                            Text("\(individualEvent.participants?.count ?? 0)").italic()
                                .font(.system(size: 18))
                                .padding(.leading, 0)
                        }
                        .foregroundColor(.orange)
                        .background(
                            Color.white
                                .cornerRadius(10)
                                .padding(25)
                                .shadow(
                                    color: .black.opacity(0.3),
                                    radius: 10,
                                    x:0, y:10
                                )
                        )
                        
                        

//                        ForEach (funvibes) { activity in
//                            NavigationLink {
//                                //
//                            } label: {
                                VStack(alignment: .leading){
                                    HStack{
                                        Text(individualEvent.description)
    //                                            .font(.subheadline)
                                            .font(.system(size: 16))
                                            .multilineTextAlignment(.leading)
                                            .lineLimit(12)
                                            // changed from 2 to 12
                                        Spacer()
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
                .padding(5)
                
            }
            
            // What is the following? Can I delete it?
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink(destination: AddActivityView()) {
//                            Image(systemName: "plus.circle")
//                            .font(Font.title.bold()).foregroundColor(.orange)
//                    }
//                }
//                ToolbarItem(placement: .navigationBarLeading) {
//                    NavigationLink(destination: MapView()) {
//                        Image(systemName: "map.circle")
//                            .font(Font.title.bold()).foregroundColor(.orange)
//                    }
//
//                }
//            }
        }
        

    }
}

#Preview {
    IndividualEventView(individualEvent: clubGameNight)
}
