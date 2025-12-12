//
//  AddressModel.swift
//  FunVibe
//
//  Created by Apprenant 78 on 12/12/2025.
//

import Foundation

public struct Address: Identifiable {
    public var id: UUID = UUID()
    public var street: String?
    public var city: String?
    public var postalCode: String?
}
