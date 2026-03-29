//
//  HomeView.swift
//  FunVibe
//
//  Created by Apprenant 78 on 10/12/2025.
//

import SwiftUI

struct ExploreView: View {
    @State var searchText: String = ""
    @State private var selectedActivity: Activity?

    var body: some View {
            NavigationStack {
                ZStack {
                    //Backgroound
                    Image("Background")
                        .resizable()
                        .opacity(0.5)
                    //Content
                    //changes i made yesterday for navigation on each image
                    //i just added image shape in label inside navigationlink

                ScrollView(.vertical){
                    VStack (alignment:.leading){
                        //carousel for images
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(funvibes) { activity in
                                    NavigationLink {
                                        IndividualEventView(individualEvent: activity)
                                    } label: {
                                        Image(activity.image ?? "photo")
                                        
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 320, height: 200)
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                    }
                                        .shadow(radius: 5)
                                        .scrollTargetLayout()
                                        
                                        }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .scrollTargetBehavior(.viewAligned)
                        .frame(height: 220)


                        //ForEach (funvibes) { activity in
                        ForEach(funvibes.filter { searchText.isEmpty || $0.title.localizedCaseInsensitiveContains(searchText) }) { activity in

                            NavigationLink {
                                IndividualEventView(individualEvent: activity)
                            } label: {
                                HStack {
                                    if activity.image == "" {
                                        Image(systemName: "photo.fill")
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                            .clipShape(Rectangle())
                                            .overlay(
                                                Rectangle()
                                                    .stroke(
                                                        Color.white,
                                                        lineWidth: 1
                                                    )
                                            )
                                            .shadow(radius: 10)
                                            .padding(.leading)
                                    }
                                    else{
                                        Image(activity.image!)
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                            .clipShape(Rectangle())
                                            .overlay(
                                                Rectangle()
                                                    .stroke(
                                                        Color.white,
                                                        lineWidth: 1
                                                    )
                                            )
                                            .shadow(radius: 10)
                                            .padding(.leading)
                                    }

                                    VStack(alignment: .leading){
                                        Text(activity.title)
                                            .font(Font.headline.bold())
                                        HStack{
                                            Text(dateFormat(date: activity.date)).italic()
                                                .padding(.trailing, 10) 
                                            Text(timeFormat(date: activity.date)).italic()
                                            Spacer()
                                            //Text(activity.category.rawValue.capitalized)
                                              //  .font(Font.caption).italic()
                                        }
                                        Text(activity.description)
                                            .font(.system(size: 18))
                                            .multilineTextAlignment(.leading)
                                            .lineLimit(1)
                                        HStack{
                                            Image(systemName: "person.2.fill")
                                            Text("Participants : \(activity.participants.count)")
                                                .font(Font.subheadline).italic()
                                        }
                                    }
                                    .padding(20)
                                }
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
                        NavigationLink(destination: AddActivityView()) {
                                Image(systemName: "plus.circle")
                                .font(Font.title.bold()).foregroundColor(.orange)
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink(destination: MapView(results: funvibes)) { //i changed this to add parameter to NavigationLink (Chris)
                            Image(systemName: "map.circle")
                                .font(Font.title.bold()).foregroundColor(.orange)
                        }

                    }
                }
               
                }

            }
                
        }

    


#Preview {
    ExploreView(searchText: "")
}
