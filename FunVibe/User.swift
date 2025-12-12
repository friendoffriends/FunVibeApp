//
//  User.swift
//  FunVibe
//
//  Created by Apprenant 84 on 12/12/25.
//

import Foundation


public struct User: Identifiable {
    public var id: UUID
    public var name: String
//    public var email: String
//    public var password: String
//    public var createdAt: Date
//    public var updatedAt: Date
    
    var friends : [User]
    
    
}

var exampleUser1: User = User(id: UUID(), name: "John", friends: [exampleUser2])
var exampleUser2: User = User(id: UUID(), name: "Jane", friends: [exampleUser1])
