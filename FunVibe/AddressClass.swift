//
//  AddressModel.swift
//  FunVibe
//
//  Created by Apprenant 78 on 12/12/2025.
//

import Foundation

class Address: Identifiable {
    var id: UUID
    var street: String?
    var city: String?
    var postCode: String?

    init(street: String? = nil, city: String? = nil, postCode: String? = nil) {
        self.id = UUID()
        self.street = street
        self.city = city
        self.postCode = postCode
    }
}


