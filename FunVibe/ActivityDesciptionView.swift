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
                    
                }}
        }
    }
    
 


#Preview {
    ActivityDescriptionView(title: "Yoga Matinal", type: "Sport", date: Date(), description: "Séance de yoga pour bien commencer la journée.")
}
