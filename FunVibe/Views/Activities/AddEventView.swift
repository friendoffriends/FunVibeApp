//
//  AddingActivityView.swift
//  FunVibe
//
//  Created by asma taberkokt on 15/12/2025.
//

import SwiftUI

struct AddEventView: View {

    @State private var title = ""
    @State private var date = Date()
    @State private var activityType = ""
    @State private var description = ""
    
    @State private var showImagePicker = false
    @State private var image: UIImage? = nil
    
    @State private var showCreatedAlert = false
    @State private var navigateToDescription = false
    let activityTypes = ["comédie", "concerts", "sports", "art et culture", "gastronomie", "famille", "jeux vidéo", "autres"]

        // Store image locally
    private let activityImageFileName = "activity_image.jpg"
    
    var body: some View {
        NavigationStack {
            ZStack {
                //Backgroound
                Image("Background")
                    .resizable()
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.all)


            ScrollView {
                VStack(spacing: 25) {

                    // Image picker
                    ZStack(alignment: .bottomTrailing) {
                        Text("choisir la photo                 ")
                            .font(.title2)

                        Group {
                            if let image = image {
                                Image(uiImage: image)
                                    .scaledToFill()
                                    .frame(width:300, height: 220)
                                    .clipped()
                                    .cornerRadius(30)
                            } else {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.1))
                                    .frame(width: 320, height: 220)
                                    .overlay(
                                        Image(systemName: "photo.on.rectangle.angled")
                                            .font(.system(size: 50))
                                            .foregroundColor(.gray)
                                    )
                                    .cornerRadius(30)
                            }
                        }
                        .frame(width: 320, height: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 30)

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
                    .padding()

                    //                    Text("Ajouter une activité")
                    //                        .font(.largeTitle)
                    //                        .fontWeight(.bold)
                    //                        .padding(.top)

                    VStack(spacing: 20) {
                        ProfileField(
                            icon: "pencil.fill",
                            title: "Nom de L'evenement",
                            placeholder: "Nom complet",
                            text: $title
                        ).font(.title)
                            .padding(10)


                        VStack(alignment: .leading) {
                            Text("Type d'activité")
                                .font(.title)
                                .fontWeight(.medium)
                                .foregroundColor(.black)
                            HStack{ Picker("Type", selection: $activityType) {
                                ForEach(activityTypes, id: \.self) { type in
                                    Text(type)
                                }
                            }
                            .pickerStyle(.wheel)
                            .scaleEffect(1.2)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(12)
                            }


                            VStack{
                                Text("choisir une date")
                                    .font(.largeTitle)
                                    .fontWeight(.medium)
                                    .foregroundColor(.black)
                                DatePicker("Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                                    .font(.title)
                                    .datePickerStyle(.wheel)
                                    .scaleEffect(1.2)
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                .cornerRadius(12)}}

                        VStack(alignment: .leading) {
                            Text("Description")
                                .font(.largeTitle)
                                .fontWeight(.medium)
                                .foregroundColor(.black)

                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(.systemBackground))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.orange.opacity(0.4), lineWidth: 0.8)
                                    )
                                    .shadow(
                                        color: Color.orange.opacity(0.25),
                                        radius: 6,
                                        x: 0,
                                        y: 0
                                    )

                                TextEditor(text: $description)
                                    .padding(12)
                                    .scrollContentBackground(.hidden)
                            }
                            .frame(height: 150)                        }
                        .font(.title)
                    }

                    Button("Créer l'événement") {
                        saveImage(image) // Save image locally
                        saveEvent()
                        showCreatedAlert = true
                    }
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .padding(.top)

                    Spacer()
                }
                .padding()
            }
            // Stylish popup
            .sheet(isPresented: $showCreatedAlert) {
                VStack(spacing: 30) {
                    Text("🎉 Activité créée! 🎉")
                        .font(.system(size: 40, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding()

                    Text("Vous pouvez maintenant consulter les détails de votre activité.")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    Button(action: {
                        showCreatedAlert = false
                        navigateToDescription = true
                    }) {
                        Text("Voir les détails")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .cornerRadius(15)
                    }
                    .padding(.horizontal, 40)
                }
                .presentationDetents([.fraction(0.5)])
            }
            .navigationDestination(isPresented: $navigateToDescription) {
                ActivityDescriptionView(
                    title: title,
                    type: activityType,
                    date: date,
                    description: description,
                )
            }
            .navigationTitle(Text("Ajouter un événement"))
        }
        }
    }

        // Save image locally
    private func saveImage(_ pickedImage: UIImage?) {
        guard let pickedImage = pickedImage,
              let data = pickedImage.jpegData(compressionQuality: 0.8) else { return }
        let url = getDocumentsDirectory().appendingPathComponent(activityImageFileName)
        try? data.write(to: url)

    }

    private func saveEvent() {
        // Save event to array funVibes
        let newEvent:Event = Event(
            title: title,
            date: date,
            location: janeAddress,
            description: description,
            image: "",
            type: .event,
            organiser: jane,
            participants: [],
            theme: .other
        )

        print(title)
        print(date)
        print(description)
        //print(activityImageFileName)


        funvibes.append(newEvent)
    }

    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

#Preview {
    AddEventView()
}
