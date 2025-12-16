//
//  CreateUserView.swift
//  FunVibe
//
//  Created by Apprenant 78 on 12/12/2025.
//

import SwiftUI

struct CreateUserView: View {
    
    @State private var fullName = ""
    @State private var email = ""
    @State private var city = ""
    @State private var phoneNumber = ""
    
    @State private var notificationsOn = false
    @State private var publicProfile = false
    
    @State private var showImagePicker = false
    @State private var image: UIImage? = nil
    
    @State private var isCreated = false
    @State private var showCreateAlert = false
    
        // MARK:  UserDefaults Keys
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
                    
                        // MARK: - Profile Image
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
                                .background(Color.orange)
                                .clipShape(Circle())
                                .shadow(radius: 3)
                        }
                        .offset(x: -10, y: -10)
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ProfileImagePicker(image: $image, onImagePicked: saveImage)
                    }
                    .onAppear {
                        loadProfile()
                    }
                    
                    Text("Creez votre profil")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                        // MARK: - Fields
                    VStack(spacing: 20) {
                        
                        ProfileField(
                            icon: "person.fill",
                            title: "Nom complet",
                            placeholder: "Nom complet",
                            text: Binding(
                                get: { fullName },
                                set: { fullName = $0 }
                            )
                        )
                        
                        ProfileField(
                            icon: "envelope.fill",
                            title: "Email",
                            placeholder: "Email",
                            text: Binding(
                                get: { email },
                                set: { email = $0 }
                            )
                        )
                        
                        ProfileField(
                            icon: "house.fill",
                            title: "Ville",
                            placeholder: "Ville",
                            text: Binding(
                                get: { city },
                                set: { city = $0 }
                            )
                        )
                        
                        ProfileField(
                            icon: "phone.fill",
                            title: "Téléphone",
                            placeholder: "Téléphone",
                            text: Binding(
                                get: { phoneNumber },
                                set: { phoneNumber = $0 }
                            )
                        )
                    }
                    
                        // MARK: - Toggles
                    Toggle("Notifications", isOn: $notificationsOn)
                        .font(.title3)
                        .tint(.orange)
                    
                    Toggle("Profil public", isOn: $publicProfile)
                        .font(.title3)
                        .tint(.orange)
                    
                        // MARK: - Create Button
                    Button("Creer mon compte") {
                        showCreateAlert = true
                    }
                    .foregroundColor(.orange)
                    .font(.title2)
                    .padding(.top)
                    .alert("Création de compte", isPresented: $showCreateAlert) {
                        
                        Button("Confirmer") {
                            saveProfile()
                            isCreated = true
                        }
                        
                        Button("Annuler", role: .cancel) { }
                        
                    } message: {
                        Text("Votre compte est bien créé")
                    }
                    
                    Spacer()
                }
                .padding()
                .navigationDestination(isPresented: $isCreated) {
                    //EditUserView() // Replace with your login/entry view
                    UserLoginView()
                }
            }
        }
    }
    
        // MARK: - Image Persistence
    private func getImageURL() -> URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?
            .appendingPathComponent(profileImageFileName)
    }
    
    private func saveImage(_ pickedImage: UIImage) {
        guard let data = pickedImage.jpegData(compressionQuality: 0.8),
              let url = getImageURL() else { return }
        try? data.write(to: url)
    }
    
    private func loadImage() {
        guard let url = getImageURL(),
              let data = try? Data(contentsOf: url),
              let savedImage = UIImage(data: data) else { return }
        image = savedImage
    }
    
    private func deleteImage() {
        guard let url = getImageURL() else { return }
        try? FileManager.default.removeItem(at: url)
    }
    
        // MARK: - Profile Persistence
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
    
    private func loadProfile() {
        fullName = UserDefaults.standard.string(forKey: fullNameKey) ?? ""
        email = UserDefaults.standard.string(forKey: emailKey) ?? ""
        city = UserDefaults.standard.string(forKey: cityKey) ?? ""
        phoneNumber = UserDefaults.standard.string(forKey: phoneKey) ?? ""
        notificationsOn = UserDefaults.standard.bool(forKey: notificationsKey)
        publicProfile = UserDefaults.standard.bool(forKey: publicProfileKey)
        loadImage()
    }
}

#Preview {
    CreateUserView()
}
