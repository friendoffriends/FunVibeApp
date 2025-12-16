//
//  CustomFunctions.swift
//  FunVibe
//
//  Created by Apprenant 78 on 11/12/2025.
//


import Foundation
import SwiftUI

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
