//
//  ActivityModel.swift
//  FunVibe
//  Created by A.Sathiesh 78 on 10/12/2025.
//

import Foundation

struct Event : Identifiable {
    var id: UUID = UUID()
    var title: String
    var date: Date = Date()
    //var time: Date = Date()
    var location: Address
    var description: String
    var image: String? = nil
    var type: ActivityType
    var organiser: String
    var participants: [String]? = []

    var Theme: String
}

struct Club  : Identifiable{
    var id: UUID = UUID()
    var title: String
    //var date: Date = Date()
    //var time: Date = Date()
    var location: Address
    var description: String
    var image: String? = nil
    var type: ActivityType
    var organiser: String
    var participants: [String]? = []

    var category: ClubCategory
    var objective: [String]
    var activities: [String]
    var subscription: Double? = 0.0
}

struct Interest: Identifiable {
    var id: UUID = UUID()
    var title: String
    var date: Date = Date()
    //var time: Date = Date()
    var location: Address
    var description: String
    var image: String? = nil
    var type: ActivityType
    var organiser: String
    var participants: [String]? = []

    var category: String
    var skillLevel: ExperienceLevel
    var difficultyLevel: DifficultyLevel
    var solo: Bool
    var duration: Double
    var cost: Double? = 0.0
    var benefit: [String]? = []
}


enum ActivityType: String {
    case event, club , interest
}

enum ClubCategory: String{
    case social_community, health_wellness, hobby_base, learning_intellectual, entertainment, recreation , technology_modern, other
}

enum ExperienceLevel: String{
    case beginner, novice, intermediate, advanced, expert, master
}

enum DifficultyLevel: String{
    case veryeasy, easy, moderate, challenging, hard, extreme
}


var events: [Any] = [
    Club(
        id: UUID(),
        title: "Spectacles d'humour",
        //date: Date(),
        //time: Date(),
        location: Address.init(id:UUID(), street: "23 Rue des Potiers", city: "Toulouse",  postalCode: "31000"),
        description: "Partager des expériences de vie humoristiques avec une touche de fiction",
        image: "",
        type: .club,
        organiser: john.name,
        category: .entertainment,
        objective: ["Partager les événements et les expériences de la vie pour rendre tout le monde heureux"],
        activities: ["Une sorte de thérapie par le rire adaptée à leur âge","Participez aux événements familiaux en tant qu'artiste de performance"],
        subscription: 0.0
    ),
    Event(
        id: UUID(),
        title: "Festival de musique",
        date: Date(),
        //time: Date(),
        location: Address.init(id: UUID(), street: "7 Rue Jules Chalande", city: "Toulouse", postalCode: "31000"),
        description: "Un festival annuel de musique proposant des concerts de tous genres",
        image: "",
        type: .event,
        organiser: john.name,
        participants: [],
        Theme: "Musique"
    ),
    Interest(
        id: UUID(),
        title: "Cuisine Italienne",
        date: Date(),
        //time: Date(),
        location: martha.address,
        description: "Un atelier de cuisine italienne proposant des cours de cuisine pour tous niveaux",
        image: "",
        type: .interest,
        organiser: martha.name,
        participants: [jane.name],
        category: "Cuisine",
        skillLevel: .intermediate,
        difficultyLevel: .veryeasy,
        solo: false,
        duration: 2.0,
        cost: 0.0,
        benefit: []
    )
]
