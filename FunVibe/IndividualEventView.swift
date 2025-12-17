//
//  IndividualEventView.swift
//  FunVibe
//
//  Created by Apprenant 84 on 12/16/25.
//


import Foundation
import SwiftUI

private let bg     = Color(red: 249/255, green: 222/255, blue: 194/255)
private let borderColor = Color(red: 243/255, green: 175/255, blue: 109/255)
private let text   = Color(red: 240/255, green: 147/255, blue:  67/255)


struct IndividualEventView: View {
//    @State var searchText: String = ""
//    @Binding var isInscrit: Bool
//    @State var individualEvent: Activity
    @State private var isInscrit = false
    @State var individualEvent: Activity
    var body: some View {
        
            //Content
            NavigationStack {
                ZStack {
                    //Backgroound
                    Image("Background")
                        .resizable()
                        .opacity(0.5)
                        .ignoresSafeArea(edges: .all)

                ScrollView(.vertical){
                    VStack (alignment:.leading){
                        HStack{
                            Text(individualEvent.title).font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.orange)
                                .padding(.leading)
                            Spacer()
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
                                .font(.system(size: 20))
                                .padding(5)
                                .padding(.leading, 10)
                            Text(timeFormat(date: individualEvent.date)).italic()
                                .font(.system(size: 20))
                            Spacer()
                        }
                        .foregroundColor(.orange)
                        .padding(5)
                        .background(
                            Color.white
                                .cornerRadius(10)
                                .shadow(
                                    color: .black.opacity(0.3),
                                    radius: 10,
                                    x:0, y:10
                                )
                        )
                        HStack{
                            Text("Participants : ").italic()
                                    .font(.system(size: 20))
                                    .padding(.leading, 15)
                            Text("\(individualEvent.participants?.count ?? 0)").italic()
                                .font(.system(size: 20))
                                .padding(5)
                            Button {
                                withAnimation(.easeInOut(duration: 0.15)) {
                                    isInscrit.toggle()
                                    
//                                    $isInscrit = true              // use: isInscrit.toggle() to allow switching back
                                }
                            } label: {
                                Label(
                                    isInscrit ? "Inscrit" : "Inscrire",
                                    systemImage: isInscrit ? "person.fill.checkmark" : "person"
                                )
//                                Label(isInscrit ? "Inscrit", systemImage: "person.fill.checkmark" : "Inscrire")
//                                Text(isInscrit ? "Inscrit \(personCheckmark.txt)" : "Inscrire")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundStyle(text)
                                    .frame(width: 150, height: 44)
                                    .background(
                                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                                            .fill(bg)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                                            .stroke(borderColor, lineWidth: 2)
                                    )
                                    .shadow(color: borderColor.opacity(0.45), radius: 3, x: 0, y: 3)
                            }
                            .buttonStyle(.plain)
                    //        .disabled(isInscrit) // remove if you want it tappable again
                            .padding(.leading, 25)
                            Spacer()
                        }
                        .foregroundColor(.orange)
                        .padding(5)
                        .background(
                            Color.white
                                .cornerRadius(10)
                                .shadow(
                                    color: .black.opacity(0.3),
                                    radius: 10,
                                    x:0, y:10
                                )
                        )
                        
                        HStack{
                            /*Text("\(individualEvent.location.street ?? "") \
                            \(individualEvent.location.city ?? "") \
                            \(individualEvent.location.postCode ?? "")")*/
//                            Text(individualEvent.location.street ?? "") + Text(" ")
//                               + Text(individualEvent.location.city ?? "") + Text(" ")
//                               + Text(individualEvent.location.postCode ?? "")
//                                .italic()
//                                .font(.system(size: 20))
//                                .padding(10)
                            (
                                Text(individualEvent.location.street ?? "") + Text(", ")
                                + Text(individualEvent.location.city ?? "") + Text(" ")
                                + Text(individualEvent.location.postCode ?? "")
                            )
                            .italic()
                            .font(.system(size: 20))
                            .padding(5)
                            .padding(10)
                            Spacer()
                            NavigationLink(destination: MapView(results: [individualEvent])) {
                                Image(systemName: "map.circle")
                                    .font(.system(size: 48, weight: .bold))
                                    .foregroundColor(.orange)
                                    .padding(.trailing, 25)

                            }
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
                       
                        
                        

//                        ForEach (funvibes) { activity in
//                            NavigationLink {
//                                //
//                            } label: {
                                VStack(alignment: .leading){
                                    HStack{
                                        Text(individualEvent.description)
    //                                            .font(.subheadline)
                                            .font(.system(size: 18))
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
        }
    }
}

#Preview {
    IndividualEventView_PreviewWrapper()
}

private struct IndividualEventView_PreviewWrapper: View {
    @State private var isInscrit = false

    var body: some View {
        IndividualEventView(individualEvent: clubGameNight)
    }
}
