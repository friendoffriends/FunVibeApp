//
//  ActivityClass.swift
//  FunVibe
//
//  Created by Apprenant 78 on 12/12/2025.
//

// This is not used



import Foundation

class Activity: Identifiable, Hashable {
    let id: UUID // changed from var 17-12-25 Chris
    var title: String
    var date: Date
    var location: Address
    var description: String
    var image: String? = nil
    var type: ActivityType
    var organiser: User
    var participants: [User]
    var imagePath: String?

    

    init(title: String, date: Date, location: Address, description: String, image: String?, type: ActivityType, organiser: User, participants: [User]) {
        self.id = UUID()
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

// Added extension to Activity to make it hashable, to work with MapView (17-12-25)
extension Activity {
    static func == (lhs: Activity, rhs: Activity) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

class Event : Activity {
    var theme: EventTheme

    init(title: String, date: Date, location: Address, description: String, image: String?, type: ActivityType, organiser: User, participants: [User], theme: EventTheme) {
        self.theme = theme
        super.init(title: title, date: date, location: location, description: description, image: image ?? "", type: type, organiser: organiser, participants: participants)
    }
}

class Club  : Activity{
    var category: ClubCategory
    var objective: [String]
    var activities: [String]
    var subscription: Double? = 0.0

    init(title: String, date: Date, location: Address, description: String, image: String?, type: ActivityType, organiser: User, participants: [User], category: ClubCategory, objective: [String], activities: [String], subscription: Double? = 0.0) {
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

    init(title: String, date:Date, location: Address, description: String, image: String?, type: ActivityType, organiser: User, participants: [User], category: String, skillLevel: ExperienceLevel, difficultyLevel: DifficultyLevel, solo: Bool, duration: Double, cost: Double? = 0.0, benefit: [String]? = []) {
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


enum ActivityType: CaseIterable {
    case event, club , interest
}

enum ClubCategory: CaseIterable {
    case social_community, health_wellness, hobby_base, learning_intellectual, entertainment, recreation , technology_modern, other
}

enum EventTheme: CaseIterable {
    case comedy, concert, sports, art_culture, food_drink, family, gaming, other
}

enum ExperienceLevel: CaseIterable {
    case beginner, novice, intermediate, advanced, expert, master, any
}

enum DifficultyLevel: CaseIterable {
    case veryeasy, easy, moderate, challenging, hard, extreme, any
}


