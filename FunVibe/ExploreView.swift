//
//  HomeView.swift
//  FunVibe
//
//  Created by Apprenant 78 on 10/12/2025.
//

import SwiftUI

struct ExploreView: View {
    @State var searchText: String = ""

    var body: some View {
            NavigationStack {
                ZStack {
                    //Backgroound
                    Image("Background")
                        .resizable()
                        .opacity(0.5)
                    //Content
                ScrollView(.vertical){
                    VStack (alignment:.leading){
                        RoundedRectangle(cornerRadius: 20)
                            .frame(height: 200)
                            .foregroundColor(.orange.opacity(0.5))
                            .padding(5)
                            .shadow(color: .blue.opacity(0.3), radius: 10,x: 0,y: 5)

                        //ForEach (funvibes) { activity in
                        ForEach(funvibes.filter { searchText.isEmpty || $0.title.localizedCaseInsensitiveContains(searchText) }) { activity in

                            NavigationLink {
                                //
                            } label: {
                                HStack {
                                    if activity.image == "" {
                                        Image(systemName: "photo.fill")
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
                                            .shadow(radius: 10)
                                            .padding(.leading)
                                    }
                                    else{
                                        Image(activity.image!)
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
                                            .shadow(radius: 10)
                                            .padding(.leading)
                                    }

                                    VStack(alignment: .leading){
                                        Text(activity.title)
                                            .font(Font.headline.bold())
                                        Text(activity.description)
                                            .font(.subheadline)
                                            .multilineTextAlignment(.leading)
                                            .lineLimit(2)
                                        HStack{
                                            Spacer()
                                            Text(dateFormat(date: activity.date)).italic()
                                            Spacer()
                                            Text(timeFormat(date: activity.date)).italic()
                                            Spacer()
                                            //Text(activity.category.rawValue.capitalized)
                                              //  .font(Font.caption).italic()
                                        }
                                        Text("Participants : ")
                                            .font(Font.caption).italic()
                                        //activity.participants == [] ? Text(0) : Text(000)
                                        //Text(activity.participants.count)

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
    ExploreView(searchText: "")
}
