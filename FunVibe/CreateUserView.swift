//
//  CreateUserView.swift
//  FunVibe
//
//  Created by Apprenant 78 on 12/12/2025.
//

import SwiftUI

struct CreateUserView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                //Backgroound
                Image("Background")
                    .resizable()
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                // Content
                Form {
                    Section(
                        header: Text("Create User")
                            .font(.largeTitle).bold()
                            .padding(.vertical,10)
                    ){
                        TextField("Name", text: .constant(""))
                        TextField("Email", text: .constant(""))
                        TextField("Phone Number", text: .constant(""))
                        TextField("Password", text: .constant(""))
                        TextField("Confirm Password", text: .constant(""))

                    }
                    .font(Font.title3)
                    .padding(5)

                    Button {
                        //
                    } label: {
                        HStack {
                            Spacer()
                            Text("Create")
                                .font(.title)
                                .frame(width: 100, alignment: .init(horizontal: .center, vertical: .center))
                            Spacer()
//                            Image(systemName: "greaterthan")
//                                .font(.largeTitle)
//                                .foregroundColor(.red)
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Create User")
    }
}

#Preview {
    CreateUserView()
}
