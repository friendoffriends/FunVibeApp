//
//  AddressModel.swift
//  FunVibe
//
//  Created by Apprenant 78 on 12/12/2025.
//

import Foundation

struct Address: Identifiable {
    var id: UUID = UUID()
    var street: String?
    var city: String?
    var postalCode: String?
}
