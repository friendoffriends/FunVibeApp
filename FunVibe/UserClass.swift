//
//  UserModel.swift
//  FunVibe
//
//  Created by Apprenant 78 on 12/12/2025.
//

import Foundation

 class User: Identifiable {
     var id: UUID
     var name: String
     var email: String
     var telephone: String?
     var password: String
     var address: Address

     init(name: String, email: String, telephone: String? = nil, password: String, address: Address) {
         self.id = UUID()
         self.name = name
         self.email = email
         self.telephone = telephone
         self.password = password
         self.address = address
     }

}



