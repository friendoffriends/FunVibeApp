//
//  CustomFunctions.swift
//  FunVibe
//
//  Created by Apprenant 78 on 11/12/2025.
//


import Foundation
import SwiftUI

func dateTimeFormat(date:Date)-> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .short
    dateFormatter.locale = Locale(identifier: "fr_FR")
    return dateFormatter.string(from: date)
}

func dateFormat(date:Date)-> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    dateFormatter.locale = Locale(identifier: "fr_FR")
    return dateFormatter.string(from: date)
    }

func timeFormat(date:Date)-> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .none
    dateFormatter.timeStyle = .short
    dateFormatter.locale = Locale(identifier: "fr_FR")
    return dateFormatter.string(from: date)
}

func setLogout() -> Void {
    UserDefaults.standard.set(false, forKey: "isLoggedIn")
    UserDefaults.standard.set(false, forKey: "isAdmin")
    UserDefaults.standard.set("", forKey: "userRef")
    }


func findUser(email:String)->User?{
    for user in users {
        if user.email == email{
            return user
        }
    }
    return nil
}

func findUserPassword(email:String, password:String)->Bool?{
    let user = findUser(email:email)
    return user?.password == password ? true : false
}


func saveAsDate(isoDate:String)->Date{
//    let calendar = Calendar.current
//    var components = DateComponents()
//    // let isoDate = "2016-04-14T10:44:00+0000"
//        components.year = 2023
//        components.month = 2
//        components.day = 14
//        components.hour = 10
//        components.minute = 30
//
//    let dateF = calendar.date(from: components) ?? Date()
//        return dateTimeFormat(date: dateF)
//        // prints 2023-02-14 08:30:00 +0000

    //let isoDate = "2016-04-14T10:44:00+0000"
    let isoDate = isoDate
    let dateFormatter = ISO8601DateFormatter()
    let date = dateFormatter.date(from:isoDate)!
    return date

}
