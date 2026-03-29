//
//  AddClubView.swift
//  FunVibe
//
//  Created by Apprenant 78 on 16/12/2025.
//

import SwiftUI

struct AddHobbyView: View {
    var body: some View {
        NavigationStack {

            ZStack {
                //Backgroound
                Image("Background")
                    .resizable()
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.all)

                //Content
                Text("Ajouter un intérêt")
            }
            .navigationTitle(Text("Ajouter un intérêt"))
        }
    }
}

#Preview {
    AddHobbyView()
}
