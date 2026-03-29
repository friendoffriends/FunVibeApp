//
//  EventMapViewModelClass.swift
//  FunVibe
//
//  Created by Apprenant 84 on 12/12/25.
//

// TODO: Commented out to edit
/*
import Foundation

import MapKit
import CoreLocation
import SwiftUI

@MainActor
final class EventMapViewModel: ObservableObject {
    @Published var eventsWithLocation: [Event] = []
    @Published var cameraPosition: MapCameraPosition = .automatic

    private let geocoder = CLGeocoder()

    func load(events: [Event]) async {
        var located: [Event] = []

        for event in events {
            // If coordinate already set, reuse it
            if event.coordinate != nil {
                located.append(event)
                continue
            }

            do {
                let placemarks = try await geocoder.geocodeAddressString(event.address)
                if let coordinate = placemarks.first?.location?.coordinate {
                    event.coordinate = coordinate
                    located.append(event)
                }
            } catch {
                print("Failed to geocode \(event.address): \(error.localizedDescription)")
            }
        }

        eventsWithLocation = located

        // Center the camera on the first event if we have one
        if let first = located.first, let coord = first.coordinate {
            cameraPosition = .region(
                MKCoordinateRegion(
                    center: coord,
                    span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                )
            )
        }
    }
}
*/
