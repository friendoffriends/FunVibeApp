//
//  UserModel.swift
//  FunVibe
//
//  Created by Apprenant 78 on 12/12/2025.
//

import Foundation

 struct User: Identifiable {
     var id: UUID = UUID()
     var name: String
     var email: String
     var telephone: String?
     var password: String
     var address: Address
}


var john = User(name: "John", email: "john@example.com", telephone:"0753445645" ,password: "password123", address: Address(street: "22 Rue Louis-François Lejeune", city: "Toulouse", postalCode: "31000"))
var ben = User(name: "Ben", email: "ben@example.com", telephone:"0753445645" ,password: "password123", address: Address(street: "31 Rue Jacques-Jean Esquie", city: "Toulouse", postalCode: "31100"))
var kevin = User(name: "Kevin", email: "kevin@example.com", telephone:"0753445645" ,password: "password123", address: Address(street: "78 Chem. du Séminaire", city: "Toulouse", postalCode: "31200"))
var martha = User(name: "Martha", email: "marth@example.com", telephone:"0753445645" ,password: "password123", address: Address(street: "28 Rue Isaac Newton", city: "Blagnac", postalCode: "31700"))
var jane = User(name: "Jane", email: "jane@example.com", telephone:"0753445645" ,password: "password123", address: Address(street: "6 Rue du Roussillon", city: "Toulouse", postalCode: "31000"))

var users: [User] = [john, ben, kevin, martha, jane]
