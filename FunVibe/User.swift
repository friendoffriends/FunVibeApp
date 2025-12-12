//
//  User.swift
//  FunVibe
//
//  Created by Apprenant 84 on 12/11/25.
//

import Foundation

struct User {
    
    // From Satiesh's activity struct
    var id: UUID = UUID()
    var name: String
    
    // TODO: create object for Address of user (in separate file)
    var home: Address
    var profilePic: String
    var hobbies: [String]
    
    // maybe allow the user to have a network
    //var network: [User]
    
    // TODO: create object for availabilities of user (in separate file)
    
}

struct Address {
    var street: String
    var city: String
    var state: String
    var zip: String
}

