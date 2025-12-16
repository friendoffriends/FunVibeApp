//
//  ActivityClass.swift
//  FunVibe
//
//  Created by Apprenant 78 on 12/12/2025.
//

// This is not used



import Foundation

class Activity: Identifiable {
    //var id: UUID
    var title: String
    var date: Date
    var location: Address
    var description: String
    var image: String? = nil
    var type: ActivityType
    var organiser: User
    var participants: [User]? = []
    var imagePath: String?

    

    init(title: String, date: Date, location: Address, description: String, image: String?, type: ActivityType, organiser: User, participants: [User]?) {
        //self.id = UUID()
        self.title = title
        self.date = date
        self.location = location
        self.description = description
        self.image = image
        self.type = type
        self.organiser = organiser
        self.participants = participants
    }
}

class Event : Activity {
    var theme: EventTheme

    init(title: String, date: Date, location: Address, description: String, image: String?, type: ActivityType, organiser: User, participants: [User]?, theme: EventTheme) {
        self.theme = theme
        super.init(title: title, date: date, location: location, description: description, image: image ?? "", type: type, organiser: organiser, participants: participants)
    }
}

class Club  : Activity{
    var category: ClubCategory
    var objective: [String]
    var activities: [String]
    var subscription: Double? = 0.0

    init(title: String, date: Date, location: Address, description: String, image: String?, type: ActivityType, organiser: User, participants: [User]?, category: ClubCategory, objective: [String], activities: [String], subscription: Double? = 0.0) {
        self.category = category
        self.objective = objective
        self.activities = activities
        super.init(title: title, date: date, location: location, description: description, image: image ?? "", type: type, organiser: organiser, participants: participants)
    }
}

class Interest: Activity {
    var category: String
    var skillLevel: ExperienceLevel
    var difficultyLevel: DifficultyLevel
    var solo: Bool
    var duration: Double
    var cost: Double? = 0.0
    var benefit: [String]? = []

    init(title: String, date:Date, location: Address, description: String, image: String?, type: ActivityType, organiser: User, participants: [User]?, category: String, skillLevel: ExperienceLevel, difficultyLevel: DifficultyLevel, solo: Bool, duration: Double, cost: Double? = 0.0, benefit: [String]? = []) {
        self.category = category
        self.skillLevel = skillLevel
        self.difficultyLevel = difficultyLevel
        self.solo = solo
        self.duration = duration
        self.cost = cost
        self.benefit = benefit
        super.init(title: title, date: date, location: location, description: description, image: image ?? "" , type: type, organiser: organiser, participants: participants)
    }
}


enum ActivityType: String {
    case event, club , interest
}

enum ClubCategory: String{
    case social_community, health_wellness, hobby_base, learning_intellectual, entertainment, recreation , technology_modern, other
}

enum EventTheme: String{
    case comedy, concert, sports, art_culture, food_drink, family, gaming, other
}

enum ExperienceLevel: String{
    case beginner, novice, intermediate, advanced, expert, master, any
}

enum DifficultyLevel: String{
    case veryeasy, easy, moderate, challenging, hard, extreme, any
}


