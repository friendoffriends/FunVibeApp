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
        
        @State private var isDeleted = false
        @State private var showDeleteAlert = false
        
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
                                // Bigger size for better visibility
                            .frame(width: 220, height: 220)
                            .clipShape(Circle())
                                //  Thin elegant border
                            .overlay(
                                Circle()
                                    .stroke(Color.orange, lineWidth: 2)
                            )
                            .shadow(radius: 5)
                            
                                //  Bigger camera button
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
                        .sheet(isPresented: $showImagePicker) {
                            ProfileImagePicker(image: $image, onImagePicked: saveImage)
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
                        
                        VStack(spacing: 20) {
                                // Save directly on editing using custom Binding
                            ProfileField(
                                icon: "person.fill",
                                title: "Nom complet",
                                placeholder: "Nom complet",
                                text: Binding(
                                    get: { fullName },
                                    set: { newValue in
                                        fullName = newValue
                                        saveProfile()
                                    }
                                )
                            )
                            
                            ProfileField(
                                icon: "envelope.fill",
                                title: "Email",
                                placeholder: "Email",
                                text: Binding(
                                    get: { email },
                                    set: { newValue in
                                        email = newValue
                                        saveProfile()
                                    }
                                )
                            )
                            
                            ProfileField(
                                icon: "house.fill",
                                title: "Ville",
                                placeholder: "Ville",
                                text: Binding(
                                    get: { city },
                                    set: { newValue in
                                        city = newValue
                                        saveProfile()
                                    }
                                )
                            )
                            
                            ProfileField(
                                icon: "phone.fill",
                                title: "Téléphone",
                                placeholder: "Téléphone",
                                text: Binding(
                                    get: { phoneNumber },
                                    set: { newValue in
                                        phoneNumber = newValue
                                        saveProfile()
                                    }
                                )
                            )
                        }
                        
                        Toggle("Notifications", isOn: Binding(
                            get: { notificationsOn },
                            set: { newValue in
                                notificationsOn = newValue
                                saveProfile()
                            }
                        ))
                        .font(.title3)
                        .tint(.orange)
                        
                        Toggle("Profil public", isOn: Binding(
                            get: { publicProfile },
                            set: { newValue in
                                publicProfile = newValue
                                saveProfile()
                            }
                        ))
                        .font(.title3)
                        .tint(.orange)
                        
                        Button("Creer mon compte") {
                            showDeleteAlert = true
                        }
                        .foregroundColor(.orange)
                        .font(.title2)
                        .padding(.top)
                        .alert("Confirmer la suppression", isPresented: $showDeleteAlert) {
                            Button("Supprimer", role: .destructive) {
                                deleteProfile()
                                isDeleted = true
                            }
                            Button("Annuler", role: .cancel) { }
                        } message: {
                            Text("Voulez-vous vraiment supprimer votre compte ? Cette action est irréversible.")
                        }
                        
                        Spacer()
                    }
                    .padding()
                }
                //.navigationTitle("Profil")
                .navigationDestination(isPresented: $isDeleted) {
                    EntryView() // Replace with your login/entry view
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
        
        private func deleteProfile() {
            fullName = ""
            email = ""
            city = ""
            phoneNumber = ""
            notificationsOn = false
            publicProfile = false
            image = nil
            deleteImage()
            
            UserDefaults.standard.removeObject(forKey: fullNameKey)
            UserDefaults.standard.removeObject(forKey: emailKey)
            UserDefaults.standard.removeObject(forKey: cityKey)
            UserDefaults.standard.removeObject(forKey: phoneKey)
            UserDefaults.standard.removeObject(forKey: notificationsKey)
            UserDefaults.standard.removeObject(forKey: publicProfileKey)
        }
    }
#Preview {
    CreateUserView()
}
