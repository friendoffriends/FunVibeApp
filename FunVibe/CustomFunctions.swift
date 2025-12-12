//
//  CustomFunctions.swift
//  FunVibe
//
//  Created by Apprenant 78 on 11/12/2025.
//


import Foundation

func dateFormat(date:Date)-> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    dateFormatter.locale = Locale(identifier: "fr_FR")
    return dateFormatter.string(from: date)
    }


