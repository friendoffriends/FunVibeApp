//
//  MapView.swift
//  FunVibeApp
//
//  Created by Apprenant 84 on 12/10/25.
//


import SwiftUI
import MapKit

struct MapView: View {
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 43.6047,   // Toulouse
                longitude: 1.4442
            ),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    )

    var body: some View {
        Map(position: $cameraPosition) {
            // add markers later if you want
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MapView()
}
