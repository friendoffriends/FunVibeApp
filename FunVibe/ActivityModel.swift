//
//  ActivityModel.swift
//  FunVibe
//  Created by A.Sathiesh 78 on 10/12/2025.
//

import Foundation

struct Event : Identifiable {
    var id: UUID = UUID()
    var title: String
    var location: String
    // var coordinate: CLLocationCoordinate2D?   // filled in later
    var date: Date = Date()
    var time: Date = Date()
    var description: String
    var image: String? = nil
    var type: ActivityType
    var Theme: String
    var organiser: User
    var participants: [User]
}

struct Club : Identifiable{
    var id: UUID = UUID()
    var title: String
    var location: String
    // var coordinate: CLLocationCoordinate2D?   // filled in later
    var description: String
    var image: String? = nil
    var type: ActivityType
    var category: ClubCategory
    var objective: [String]
    var activities: [String]
    var subscription: Double? = 0.0
    var organiser: User
}

// This struct Workshop is not necessary

/*
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
*/

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


var exampleClub1 : Club = Club(
        id: UUID(),
        title: "Spectacles d'humour",
        location: "Club de loisiers, 31000 Toulouse",
        description: "Partager des expériences de vie humoristiques avec une touche de fiction",
        image: "",
        type: .club,
        category: .entertainment,
        objective: ["Partager les événements et les expériences de la vie pour rendre tout le monde heureux"],
        activities: ["Une sorte de thérapie par le rire adaptée à leur âge","Participez aux événements familiaux en tant qu'artiste de performance"],
        subscription: 0.0,
        organiser: exampleUser1
    )

var exampleClub2 : Club = Club(
        id: UUID(),
        title: "Échecs",
        location: "Club d'échecs, 31300 Toulouse",
        description: "Partager des expériences de vie humoristiques avec une touche de fiction",
        image: "",
        type: .club,
        category: .entertainment,
        objective: ["Jouer aux échecs"],
        activities: ["Échecs"],
        subscription: 0.0,
        organiser: exampleUser2
    )

var exampleClubList : [Club] = [exampleClub1, exampleClub2]


var activities : [Identifiable] = [
    Club(title: <#T##String#>, location: <#T##String#>, description: <#T##String#>, type: <#T##ActivityType#>, category: <#T##ClubCategory#>, objective: <#T##[String]#>, activities: <#T##[String]#>, organiser: <#T##User#>),
    Event(title: <#T##String#>, location: <#T##String#>, description: <#T##String#>, type: <#T##ActivityType#>, Theme: <#T##String#>, organiser: <#T##User#>, participants: <#T##[User]#>),
    Interest(title: <#T##String#>, location: <#T##String#>, description: <#T##String#>, type: <#T##ActivityType#>, category: <#T##String#>, skillLevel: <#T##ExperienceLevel#>, difficultyLevel: <#T##DifficultyLevel#>, solo: <#T##Bool#>, duration: <#T##Double#>)
]
