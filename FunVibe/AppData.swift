//
//  AppData.swift
//  FunVibe
//
//  Created by Apprenant 78 on 14/12/2025.
//

import Foundation

/// ADDRESS //////////////////////

var johnAddress: Address {Address(street: "22 Rue Louis-François Lejeune",city: "Toulouse",postCode: "31000")}
var benAddress: Address {Address(street: "31 Rue Jacques-Jean Esquie", city: "Toulouse", postCode: "31100")}
var kevinAddress: Address {Address(street: "78 Chem. du Séminaire", city: "Toulouse", postCode: "31200")}
var marthaAddress: Address {Address(street: "28 Rue Isaac Newton", city: "Blagnac", postCode: "31700")}
var janeAddress: Address {Address(street: "6 Rue du Roussillon", city: "Toulouse", postCode: "31000")}

var club1Address: Address {Address(street: "10 Chem. de Liffard",city: "Toulouse",postCode: "31000")}
var club2Address: Address {Address(street: "78 Chem. du Loup", city: "Toulouse", postCode: "31100")}

var event1Address: Address {Address(street: "3 Rue Hubert Monloup", city: "Toulouse", postCode: "31200")}
var event2Address: Address {Address(street: "167 Rue du Riou", city: "Beauzelle", postCode: "31700")}


var addresses: [Address] = [
    johnAddress, benAddress, kevinAddress, marthaAddress, janeAddress,
    club1Address,club2Address,
    event1Address,event2Address
]


/// USER //////////////////////////////////
var john = User(fullName: "John", email: "john@gmail.com", phoneNumber:"0753445645" ,password: "password1234", address: johnAddress)
var ben = User(fullName: "Ben", email: "ben@outlook.com", phoneNumber:"0753445645" ,password: "password2345", address: benAddress)
var kevin = User(fullName: "Kevin", email: "kevin@google.com", phoneNumber:"0753445645" ,password: "password3456", address: kevinAddress)
var martha = User(fullName: "Martha", email: "marth@yahoo.com", phoneNumber:"0753445645" ,password: "password4567", address: marthaAddress)
var jane = User(fullName: "Jane", email: "jane@sfr.fr", phoneNumber:"0753445645" ,password: "password5678", address: janeAddress)


var users: [User] = [john, ben, kevin, martha, jane]



/// ACTIVITIES /////////////////////////////
var clubGameNight:Club = Club(
    title: "Game Night",
    date: saveAsDate(isoDate: "2025-12-27T18:30:00+0100"),
    location: club1Address,
    description: "Join us for a night of epic battles and epic snacks!",
    image:  "Game-Night-image",
    type: .club,
    organiser: john,
    participants: [john, ben, kevin],
    category: .hobby_base,
    objective: ["Have fun", "Make new friends"],
    activities: ["Video games", "Board games", "Card games"]
    )

var bookClub:Club = Club(
    title: "Book Club",
    date: saveAsDate(isoDate: "2025-12-28T17:00:00+0100"),
    location: club2Address,
    description: "Read fascinating books and connect with like-minded people!",
    image:  "Book-Club-image",
    type: .club,
    organiser: ben,
    participants: [martha, jane],
    category: .hobby_base,
    objective: ["Read more", "Connect with like-minded people"],
    activities: ["Book clubs", "Reading challenges"]
    )

var eventComedyShow:Event = Event(
    title: "Comedy Show",
    date: saveAsDate(isoDate: "2025-12-31T18:30:00+0100"),
    location: event1Address,
    description: "Catch a comedy show that will make you laugh out loud!",
    image:  "Comedy-show-image",
    type: .event,
    organiser: jane,
    participants: [john, ben, kevin],
    theme: .comedy
    )

var majongInterest: Interest = Interest(
    title: "Mahjong Challenge",
    date: saveAsDate(isoDate: "2026-01-03T15:30:00+0100"),
    location: event2Address,
    description: "Challenge your friends to a game of mahjong!",
    image: "majong-image",
    type: .interest,
    organiser: martha,
    participants: [jane, ben, kevin, john, martha],
    category: "joue de stratégie",
    skillLevel: .any,
    difficultyLevel: .any,
    solo: false,
    duration: 1.0,
    cost: 0.0,
    benefit: ["New friends", "Social interaction"],

)


var funvibes: [Activity] = [
    clubGameNight,bookClub,eventComedyShow, majongInterest
]
