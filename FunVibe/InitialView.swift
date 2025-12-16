//
//  InitialView.swift
//  FunVibe
//
//  Created by Apprenant 78 on 11/12/2025.
//

import SwiftUI

struct InitialView: View {
    //@AppStorage("isLoggedIn") private var isLoggedIn = false
    //@Environment(\.isLoggedIn) private var isLoggedIn

    var body: some View {
        if (UserDefaults.standard.bool(forKey: "isLoggedIn") == true ) {
            HomeView()
        } else {
            EntryView()
        }
    }
}
