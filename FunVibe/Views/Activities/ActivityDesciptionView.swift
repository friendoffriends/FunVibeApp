//
//  ActivityDesciptionView.swift
//  FunVibe
//
//  Created by asma taberkokt on 15/12/2025.
//
import SwiftUI

struct ActivityDescriptionView: View {
    
    var title: String
    var type: String
    var date: Date
    var description: String
    
        
        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {

                    // Event Image
                    Image("books")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 220)
                        .clipped()
                        .cornerRadius(20)

                    // Title
                    Text("Soirée club de lecture")
                        .font(.title)
                        .fontWeight(.bold)

                    // Date
                    HStack {
                        Image(systemName: "calendar")
                        Text("Mardi 16 décembre 2025 • 19:00 – 21:00")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                    // Location Card
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(.red)
                            Text("Eurokafé - Toulouse")
                                .fontWeight(.semibold)
                        }

                        Text("13 boulevard Lascrosses, 31000 Toulouse")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(16)

                    // Free badge
                    Text("Gratuit")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(12)

                    // Participate Button
                    Button(action: {
                        print("Participer tapped")
                    }) {
                        Text("Participer")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                    }
                    .padding(.top)
                }
                .padding()
            }
        }
}

 


#Preview {
    ActivityDescriptionView(title: "Yoga Matinal", type: "Sport", date: Date(), description: "Séance de yoga pour bien commencer la journée.")
}
