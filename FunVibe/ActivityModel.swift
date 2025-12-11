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
    var time: Date = Date()
    var location: String
    var description: String
    var image: String? = nil
    var type: ActivityType
    var Theme: String
    var organiser: String
    var participants: [String]
}

struct Club  : Identifiable{
    var id: UUID = UUID()
    var title: String
    var date: Date = Date()
    var time: Date = Date()
    var location: String
    var description: String
    var image: String? = nil
    var type: ActivityType

    var category: ClubCategory
    var objective: [String]
    var activities: [String]
    var subscription: Double? = 0.0
}

struct Workshop: Identifiable {
    var id: UUID = UUID()
    var title: String
    var date: Date = Date()
    var time: Date = Date()
    var location: String
    var description: String
    var image: String? = nil
    var type: ActivityType

    var triner: String
    var target: [String]
    var capacity: Int
    var fee: Double? = 0.0
    var objecive: String
}

struct Interest: Identifiable {
    var id: UUID = UUID()
    var title: String
    var date: Date = Date()
    var time: Date = Date()
    var location: String
    var description: String
    var image: String? = nil
    var type: ActivityType

    var category: String
    var skillLevel: ExperienceLevel
    var difficultyLevel: DifficultyLevel
    var solo: Bool
    var duration: Double
    var cost: Double? = 0.0
    var benefit: [String]? = []
}


enum ActivityType: String {
    case event, club, workshop , interest
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



var clubs: [Club] = [
    Club(
       // id: UUID(),
        title: "Spectacles d'humour",
        date: Date(),
        time: Date(),
        location: "Club de loisiers, 31000 Toulouse",
        description: "Partager des expériences de vie humoristiques avec une touche de fiction",
        image: "",
        type: .club,
        category: .entertainment,
        objective: ["Partager les événements et les expériences de la vie pour rendre tout le monde heureux"],
        activities: ["Une sorte de thérapie par le rire adaptée à leur âge","Participez aux événements familiaux en tant qu'artiste de performance"],
        subscription: 0.0
    )
]
