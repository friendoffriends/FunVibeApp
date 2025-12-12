//
//  ClassActivity.swift
//  FunVibe
//
//  Created by Apprenant 84 on 12/11/25.
//


// Rewrite the following structs as a class Activity, with subclasses: Club and Event. Event requires

// Probably won't use this class, unless we have time to rewrite

/*
import Foundation

class Activity {
    var id: UUID = UUID()
    var title: String
    var availabilty =
    var date: Date = Date()
    var time: Date = Date()
    var location: String
    var description: String
    var image: String? = nil
    var type: ActivityType
    
    var Theme: String
    var organiser: User
    var participants: [User]
    
    Designated initializer
        init(name: String, age: Int) {
            self.name = name
            self.age = age
        }
}

class Event : Activity {
    
}

class Club : Activity {
    
}

*/

// Previous version
/*
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
*/


//Previous Activity struct

//struct Event : Identifiable {
//    var id: UUID = UUID()
//    var title: String
//    var date: Date = Date()
//    var time: Date = Date()
//    var location: String
//    var description: String
//    var image: String? = nil
//    var type: ActivityType
//    
//    var Theme: String
//    var organiser: String
//    var participants: [String]
//}
//
//struct Club  : Identifiable{
//    var id: UUID = UUID()
//    var title: String
//    var date: Date = Date()
//    var time: Date = Date()
//    var location: String
//    var description: String
//    var image: String? = nil
//    var type: ActivityType
//
//    var category: ClubCategory
//    var objective: [String]
//    var activities: [String]
//    var subscription: Double? = 0.0
//}
//
//struct Workshop: Identifiable {
//    var id: UUID = UUID()
//    var title: String
//    var date: Date = Date()
//    var time: Date = Date()
//    var location: String
//    var description: String
//    var image: String? = nil
//    var type: ActivityType
//
//    var triner: String
//    var target: [String]
//    var capacity: Int
//    var fee: Double? = 0.0
//    var objecive: String
//}
//
//struct Interest: Identifiable {
//    var id: UUID = UUID()
//    var title: String
//    var date: Date = Date()
//    var time: Date = Date()
//    var location: String
//    var description: String
//    var image: String? = nil
//    var type: ActivityType
//
//    var category: String
//    var skillLevel: ExperienceLevel
//    var difficultyLevel: DifficultyLevel
//    var solo: Bool
//    var duration: Double
//    var cost: Double? = 0.0
//    var benefit: [String]? = []
//}
//
//
//enum ActivityType: String {
//    case event, club, workshop , interest
//}
//
//enum ClubCategory: String{
//    case social_community, health_wellness, hobby_base, learning_intellectual, entertainment, recreation , technology_modern, other
//}
//
//enum ExperienceLevel: String{
//    case beginner, novice, intermediate, advanced, expert, master
//}
//
//enum DifficultyLevel: String{
//    case veryeasy, easy, moderate, challenging, hard, extreme
//}
//
//
//
//var clubs: [Club] = [
//    Club(
//       // id: UUID(),
//        title: "Spectacles d'humour",
//        date: Date(),
//        time: Date(),
//        location: "Club de loisiers, 31000 Toulouse",
//        description: "Partager des expériences de vie humoristiques avec une touche de fiction",
//        image: "",
//        type: .club,
//        category: .entertainment,
//        objective: ["Partager les événements et les expériences de la vie pour rendre tout le monde heureux"],
//        activities: ["Une sorte de thérapie par le rire adaptée à leur âge","Participez aux événements familiaux en tant qu'artiste de performance"],
//        subscription: 0.0
//    )
//]
