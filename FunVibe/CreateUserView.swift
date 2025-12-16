//
//  CreateUserView.swift
//  FunVibe
//
//  Created by Apprenant 78 on 12/12/2025.
//

    //
    //  AddActivityView.swift
    //  FunVibe
    //
    //  Created by Apprenant 78 on 10/12/2025.
    //

    //
    //  AddActivityView.swift
    //  FunVibe
    //
    //  Created by Apprenant 78 on 10/12/2025.
    //
    //  CreateUserView.swift
    //  FunVibe
    //
    //  Created by asma taberkokt on 15/12/2025.
    //
    //  CreateUserView.swift
    //  FunVibe
    //
    //  Created by asma taberkokt on 15/12/2025.
    //

import SwiftUI
import UIKit

struct CreateUserView: View {
    
    @State private var fullName = ""
    @State private var email = ""
    @State private var city = ""
    @State private var phoneNumber = ""
    
    @State private var notificationsOn = false
    @State private var publicProfile = false
    
    @State private var showImagePicker = false
    @State private var image: UIImage? = nil
    
    @State private var showCreatedAlert = false
    @State private var navigateToEdit = false
    @State private var isCreated: Bool = false

        // Keys for UserDefaults
    private let profileImageFileName = "profile.jpg"
    private let fullNameKey = "fullName"
    private let emailKey = "email"
    private let cityKey = "city"
    private let phoneKey = "phoneNumber"
    private let notificationsKey = "notificationsOn"
    private let publicProfileKey = "publicProfile"
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 30) {
                    
                        // Profile Image + Camera
                    ZStack(alignment: .bottomTrailing) {
                        Group {
                            if let image = image {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                            } else {
                                Image(systemName: "person.crop.circle.fill")
                                    .resizable()
                                    .foregroundColor(.gray.opacity(0.6))
                            }
                        }
                        .frame(width: 220, height: 220)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.orange, lineWidth: 2)
                        )
                        .shadow(radius: 5)
                        
                        Button {
                            showImagePicker = true
                        } label: {
                            Image(systemName: "camera.fill")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .foregroundColor(.white)
                                .padding(14)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .shadow(radius: 3)
                        }
                        .offset(x: -10, y: -10)
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ProfileImagePicker(image: $image, onImagePicked: saveImage)
                    }
                    
                    Text("Créer votre profil")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    VStack(spacing: 20) {
                        ProfileField(icon: "person.fill", title: "Nom complet", placeholder: "Nom complet", text: $fullName)
                        ProfileField(icon: "envelope.fill", title: "Email", placeholder: "Email", text: $email)
                        ProfileField(icon: "house.fill", title: "Ville", placeholder: "Ville", text: $city)
                        ProfileField(icon: "phone.fill", title: "Téléphone", placeholder: "Téléphone", text: $phoneNumber)
                    }
                    
                    Toggle("Notifications", isOn: $notificationsOn)
                        .font(.title3)
                        .tint(.orange)
                    
                    Toggle("Profil public", isOn: $publicProfile)
                        .font(.title3)
                        .tint(.orange)
                    
                    Button("Créer mon compte") {
                        saveProfile()
                        showCreatedAlert = true
                    }
                    .font(.title2)
                    .padding(.top)
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                    
                    Spacer()
                }
                .padding()
                .navigationDestination(isPresented: $isCreated) {
                    //EditUserView() // Replace with your login/entry view
                    UserLoginView()
                }
                .presentationDetents([.fraction(0.5)])
            }
            .navigationDestination(isPresented: $navigateToEdit) {
                EditUserView()
            }
        }
    }
    
        // MARK: - Profile Persistence
    private func getImageURL() -> URL? {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return documents?.appendingPathComponent(profileImageFileName)
    }
    
    private func saveImage(_ pickedImage: UIImage) {
        guard let data = pickedImage.jpegData(compressionQuality: 0.8),
              let url = getImageURL() else { return }
        try? data.write(to: url)
    }
    
    private func saveProfile() {
        UserDefaults.standard.set(fullName, forKey: fullNameKey)
        UserDefaults.standard.set(email, forKey: emailKey)
        UserDefaults.standard.set(city, forKey: cityKey)
        UserDefaults.standard.set(phoneNumber, forKey: phoneKey)
        UserDefaults.standard.set(notificationsOn, forKey: notificationsKey)
        UserDefaults.standard.set(publicProfile, forKey: publicProfileKey)
        
        if let img = image {
            saveImage(img)
        }

        isCreated = true

        //init(fullName: String, email: String, phoneNumber: String? = nil, password: String, address: Address, notificationsOn: Bool? = nil, publicProfile: Bool = false)
        let user = User(
            fullName: fullName,
            email: email,
            phoneNumber: phoneNumber,
            password: "password",
            address: Address(street:"", city: city, postCode: ""),
            notificationsOn: notificationsOn,
            publicProfile: publicProfile
        )
        users.append(user)
    }
}

#Preview {
    CreateUserView()
}
