//
//  UserModel.swift
//  FunVibe
//
//  Created by Apprenant 78 on 12/12/2025.
//

import Foundation

 class User: Identifiable {
     //var id: UUID
     var fullName: String
     var email: String
     var phoneNumber: String?
     var password: String
     var address: Address
    //var city : String
     var notificationsOn: Bool? = false
    var publicProfile = false

    init(fullName: String, email: String, phoneNumber: String? = nil, password: String, address: Address, notificationsOn: Bool? = nil, publicProfile: Bool = false) {
         //self.id = UUID()
         self.fullName = fullName
         self.email = email
         self.phoneNumber = phoneNumber
         self.password = password
         self.address = address
         self.notificationsOn = notificationsOn
         self.publicProfile = publicProfile
     }
     
}



