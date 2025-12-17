//
//  MapView.swift
//  FunVibeApp
//
//  Created by Apprenant 84 on 12/10/25.
//

//
//  MapView.swift
//  FunVibe
//
//  Created by Apprenant 84 on 12/15/25.
//


// v3 17-12-25

import SwiftUI
import MapKit
import CoreLocation

/// iOS 17+ SwiftUI Map that geocodes each Activity.location (Address) and shows pins.
/// Tap a pin to navigate to IndividualEventView for that Activity.
struct MapView: View {
    let results: [Activity]

    @State private var cameraPosition: MapCameraPosition = .region(Self.defaultRegion)
    @State private var pins: [ActivityPin] = []

    @State private var isGeocoding = false
    @State private var geocodeCache: [String: CLLocationCoordinate2D] = [:]
    @State private var failedAddresses: Set<String> = []

    // Navigation selection
    @State private var selectedActivity: Activity?

    var body: some View {
        Map(position: $cameraPosition) {
            ForEach(pins) { pin in
                Annotation(pin.activity.title, coordinate: pin.coordinate, anchor: .bottom) {
                    Button {
                        selectedActivity = pin.activity
                    } label: {
                        VStack(spacing: 2) {
                            Image(systemName: "mappin.circle.fill")
                                .font(.title2)
                                .foregroundStyle(.red)

                            Text(pin.activity.title)
                                .font(.caption2)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 3)
                                .background(.thinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                .lineLimit(1)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .mapControls {
            MapCompass()
            MapScaleView()
        }
        .overlay(alignment: .top) {
            if isGeocoding {
                ProgressView("Locating activities…")
                    .padding(10)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.top, 12)
            } else if pins.isEmpty {
                ContentUnavailableView("No locations to show", systemImage: "map")
                    .padding(.top, 12)
            }
        }
        .overlay(alignment: .bottom) {
            if !failedAddresses.isEmpty {
                Text("Couldn’t locate \(failedAddresses.count) address(es).")
                    .font(.caption)
                    .padding(8)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.bottom, 12)
            }
        }
        // IMPORTANT: This requires MapView to be inside a NavigationStack somewhere above it.
        .navigationDestination(item: $selectedActivity) { activity in
            IndividualEventView(individualEvent: activity)
        }
        .task(id: resultsSignature) {
            await geocodeAndUpdateMap()
        }
    }

    // MARK: - Trigger key (reruns when address strings change)
    private var resultsSignature: String {
        results
            .map { "\($0.id.uuidString)|\($0.location.geocodingString ?? "")" }
            .joined(separator: "||")
    }

    // MARK: - Geocoding + pins + camera

    private func geocodeAndUpdateMap() async {
        let pending: [PendingPin] = results.compactMap { activity in
            guard let addressString = activity.location.geocodingString else { return nil }
            return PendingPin(activity: activity, addressString: addressString)
        }

        guard !pending.isEmpty else {
            await MainActor.run {
                pins = []
                cameraPosition = .region(Self.defaultRegion)
                failedAddresses = []
                isGeocoding = false
            }
            return
        }

        await MainActor.run { isGeocoding = true }

        // Work on local copies, then commit back to State once.
        let startingCache = await MainActor.run { geocodeCache }
        var localCache = startingCache
        var localFailed: Set<String> = []

        let uniqueAddresses = Array(Set(pending.map(\.addressString))).sorted()
        let geocoder = CLGeocoder()

        for address in uniqueAddresses {
            if Task.isCancelled { break }
            if localCache[address] != nil { continue }

            do {
                let placemarks = try await geocoder.geocode(address)
                if let coordinate = placemarks.first?.location?.coordinate {
                    localCache[address] = coordinate
                } else {
                    localFailed.insert(address)
                }
            } catch {
                localFailed.insert(address)
            }

            // Light pacing helps reduce rate limiting if you have many results.
            try? await Task.sleep(nanoseconds: 200_000_000)
        }

        let builtPins: [ActivityPin] = pending.compactMap { p in
            guard let c = localCache[p.addressString] else { return nil }
            return ActivityPin(activity: p.activity, coordinate: c)
        }

        let newRegion = regionToFit(builtPins.map(\.coordinate)) ?? Self.defaultRegion

        await MainActor.run {
            geocodeCache = localCache
            failedAddresses = localFailed
            pins = builtPins
            cameraPosition = .region(newRegion)
            isGeocoding = false
        }
    }

    // MARK: - Region fitting

    private func regionToFit(_ coordinates: [CLLocationCoordinate2D]) -> MKCoordinateRegion? {
        guard let first = coordinates.first else { return nil }

        var minLat = first.latitude, maxLat = first.latitude
        var minLon = first.longitude, maxLon = first.longitude

        for c in coordinates.dropFirst() {
            minLat = min(minLat, c.latitude)
            maxLat = max(maxLat, c.latitude)
            minLon = min(minLon, c.longitude)
            maxLon = max(maxLon, c.longitude)
        }

        let center = CLLocationCoordinate2D(
            latitude: (minLat + maxLat) / 2,
            longitude: (minLon + maxLon) / 2
        )

        let latDelta = max(0.02, (maxLat - minLat) * 1.25)
        let lonDelta = max(0.02, (maxLon - minLon) * 1.25)

        return MKCoordinateRegion(
            center: center,
            span: MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        )
    }

    private static let defaultRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 43.6047, longitude: 1.4442), // Toulouse fallback
        span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
    )
}

// MARK: - Helper models

private struct PendingPin {
    let activity: Activity
    let addressString: String
}

private struct ActivityPin: Identifiable {
    let activity: Activity
    let coordinate: CLLocationCoordinate2D
    var id: UUID { activity.id }
}

// MARK: - Address -> string for geocoding

private extension Address {
    var geocodingString: String? {
        let parts = [street, postCode, city]
            .compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }

        guard !parts.isEmpty else { return nil }
        return parts.joined(separator: ", ")
    }
}

// MARK: - Async geocoding helper

private extension CLGeocoder {
    func geocode(_ addressString: String) async throws -> [CLPlacemark] {
        try await withCheckedThrowingContinuation { continuation in
            geocodeAddressString(addressString) { placemarks, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: placemarks ?? [])
                }
            }
        }
    }
}

// › // i don't know what this is for


// v2.1 test for addresses
/*
import SwiftUI
import MapKit
import CoreLocation

/// iOS 17+ (non-deprecated) SwiftUI Map that geocodes each Activity.location (Address) and shows pins.
struct MapView: View {
    @State private var results: [Activity] = funvibes // Should this be private or public?

    @State private var cameraPosition: MapCameraPosition = .region(Self.defaultRegion)
    @State private var pins: [ActivityPin] = []

    @State private var isGeocoding = false
    @State private var geocodeCache: [String: CLLocationCoordinate2D] = [:]
    @State private var failedAddresses: Set<String> = []

    var body: some View {
        
            ForEach(funvibes) {exampleActivity in
                VStack(spacing: 2) {
//                    exampleActivity.location.geocodingString ??
                    Text("Unknown location")
                }
            }
    }

    // MARK: - Trigger key (reruns when address strings change)
    private var resultsSignature: String {
        results
            .map { "\($0.id.uuidString)|\($0.location.geocodingString ?? "")" }
            .joined(separator: "||")
    }

    // MARK: - Geocoding + pins + camera

    private func geocodeAndUpdateMap() async {
        let pending: [PendingPin] = results.compactMap { activity in
            guard let addressString = activity.location.geocodingString else { return nil }
            return PendingPin(id: activity.id, title: activity.title, addressString: addressString)
        }

        guard !pending.isEmpty else {
            await MainActor.run {
                pins = []
                cameraPosition = .region(Self.defaultRegion)
                failedAddresses = []
                isGeocoding = false
            }
            return
        }

        await MainActor.run { isGeocoding = true }

        // Work on local copies, then commit back to State once.
        let startingCache = await MainActor.run { geocodeCache }
        var localCache = startingCache
        var localFailed: Set<String> = []

        let uniqueAddresses = Array(Set(pending.map(\.addressString))).sorted()
        let geocoder = CLGeocoder()

        for address in uniqueAddresses {
            if Task.isCancelled { break }
            if localCache[address] != nil { continue }

            do {
                let placemarks = try await geocoder.geocode(address)
                if let coordinate = placemarks.first?.location?.coordinate {
                    localCache[address] = coordinate
                } else {
                    localFailed.insert(address)
                }
            } catch {
                localFailed.insert(address)
            }

            // Light pacing helps reduce rate limiting if you have many results.
            try? await Task.sleep(nanoseconds: 200_000_000)
        }

        let builtPins: [ActivityPin] = pending.compactMap { p in
            guard let c = localCache[p.addressString] else { return nil }
            return ActivityPin(id: p.id, title: p.title, coordinate: c)
        }

        let newRegion = regionToFit(builtPins.map(\.coordinate)) ?? Self.defaultRegion

        await MainActor.run {
            geocodeCache = localCache
            failedAddresses = localFailed
            pins = builtPins
            cameraPosition = .region(newRegion)
            isGeocoding = false
        }
    }

    // MARK: - Region fitting

    private func regionToFit(_ coordinates: [CLLocationCoordinate2D]) -> MKCoordinateRegion? {
        guard let first = coordinates.first else { return nil }

        var minLat = first.latitude, maxLat = first.latitude
        var minLon = first.longitude, maxLon = first.longitude

        for c in coordinates.dropFirst() {
            minLat = min(minLat, c.latitude)
            maxLat = max(maxLat, c.latitude)
            minLon = min(minLon, c.longitude)
            maxLon = max(maxLon, c.longitude)
        }

        let center = CLLocationCoordinate2D(
            latitude: (minLat + maxLat) / 2,
            longitude: (minLon + maxLon) / 2
        )

        let latDelta = max(0.02, (maxLat - minLat) * 1.25)
        let lonDelta = max(0.02, (maxLon - minLon) * 1.25)

        return MKCoordinateRegion(
            center: center,
            span: MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        )
    }

    private static let defaultRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 43.6047, longitude: 1.4442), // Toulouse fallback
        span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
    )
}

// MARK: - Helper models

private struct PendingPin {
    let id: UUID
    let title: String
    let addressString: String
}

private struct ActivityPin: Identifiable {
    let id: UUID
    let title: String
    let coordinate: CLLocationCoordinate2D
}

// MARK: - Address -> string for geocoding

private extension Address {
    /// Example: "10 Rue Alsace Lorraine, 31000, Toulouse"
    var geocodingString: String? {
        let parts = [street, postCode, city]
            .compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }

        guard !parts.isEmpty else { return nil }
        return parts.joined(separator: ", ")
    }
}

// MARK: - Async geocoding helper (works regardless of SDK async convenience availability)

private extension CLGeocoder {
    func geocode(_ addressString: String) async throws -> [CLPlacemark] {
        try await withCheckedThrowingContinuation { continuation in
            geocodeAddressString(addressString) { placemarks, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: placemarks ?? [])
                }
            }
        }
    }
}
*/
 
// v2
/*
import SwiftUI
import MapKit
import CoreLocation

/// iOS 17+ (non-deprecated) SwiftUI Map that geocodes each Activity.location (Address) and shows pins.
struct MapView: View {
    let results: [Activity]
    @State private var cameraPosition: MapCameraPosition = .region(Self.defaultRegion)
    @State private var pins: [ActivityPin] = []
    @State private var isGeocoding = false
    @State private var geocodeCache: [String: CLLocationCoordinate2D] = [:]
    @State private var failedAddresses: Set<String> = []

    var body: some View {
        Map(position: $cameraPosition) {
            ForEach(pins) { pin in
                
                    Annotation(pin.title, coordinate: pin.coordinate, anchor: .bottom) {
                        VStack(spacing: 2) {
                            Image(systemName: "mappin.circle.fill")
                                .font(.title2)
                                .foregroundStyle(.red)

                            Text(pin.title)
                                .font(.caption2)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 3)
                                .background(.thinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                .lineLimit(1)
                        }
                    }
//                NavigationLink {
//                    // need to redo
////                    IndividualEventView(individualEvent: pin)
//                } label: {
//                    }
               
            }
        }
        .mapControls {
            MapCompass()
            MapScaleView()
        }
        .overlay(alignment: .top) {
            if isGeocoding {
                ProgressView("Locating activities…")
                    .padding(10)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.top, 12)
            } else if pins.isEmpty {
                ContentUnavailableView("No locations to show", systemImage: "map")
                    .padding(.top, 12)
            }
        }
        .overlay(alignment: .bottom) {
            if !failedAddresses.isEmpty {
                Text("Couldn’t locate \(failedAddresses.count) address(es).")
                    .font(.caption)
                    .padding(8)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.bottom, 12)
            }
        }
        .task(id: resultsSignature) {
            await geocodeAndUpdateMap()
        }
    }

    // MARK: - Trigger key (reruns when address strings change)
    private var resultsSignature: String {
        results
            .map { "\($0.id.uuidString)|\($0.location.geocodingString ?? "")" }
            .joined(separator: "||")
    }

    // MARK: - Geocoding + pins + camera

    private func geocodeAndUpdateMap() async {
        let pending: [PendingPin] = results.compactMap { activity in
            guard let addressString = activity.location.geocodingString else { return nil }
            return PendingPin(id: activity.id, title: activity.title, addressString: addressString)
        }

        guard !pending.isEmpty else {
            await MainActor.run {
                pins = []
                cameraPosition = .region(Self.defaultRegion)
                failedAddresses = []
                isGeocoding = false
            }
            return
        }

        await MainActor.run { isGeocoding = true }

        // Work on local copies, then commit back to State once.
        let startingCache = await MainActor.run { geocodeCache }
        var localCache = startingCache
        var localFailed: Set<String> = []

        let uniqueAddresses = Array(Set(pending.map(\.addressString))).sorted()
        let geocoder = CLGeocoder()

        for address in uniqueAddresses {
            if Task.isCancelled { break }
            if localCache[address] != nil { continue }

            do {
                let placemarks = try await geocoder.geocode(address)
                if let coordinate = placemarks.first?.location?.coordinate {
                    localCache[address] = coordinate
                } else {
                    localFailed.insert(address)
                }
            } catch {
                localFailed.insert(address)
            }

            // Light pacing helps reduce rate limiting if you have many results.
            try? await Task.sleep(nanoseconds: 200_000_000)
        }

        let builtPins: [ActivityPin] = pending.compactMap { p in
            guard let c = localCache[p.addressString] else { return nil }
            return ActivityPin(id: p.id, title: p.title, coordinate: c)
        }

        let newRegion = regionToFit(builtPins.map(\.coordinate)) ?? Self.defaultRegion

        await MainActor.run {
            geocodeCache = localCache
            failedAddresses = localFailed
            pins = builtPins
            cameraPosition = .region(newRegion)
            isGeocoding = false
        }
    }

    // MARK: - Region fitting

    private func regionToFit(_ coordinates: [CLLocationCoordinate2D]) -> MKCoordinateRegion? {
        guard let first = coordinates.first else { return nil }

        var minLat = first.latitude, maxLat = first.latitude
        var minLon = first.longitude, maxLon = first.longitude

        for c in coordinates.dropFirst() {
            minLat = min(minLat, c.latitude)
            maxLat = max(maxLat, c.latitude)
            minLon = min(minLon, c.longitude)
            maxLon = max(maxLon, c.longitude)
        }

        let center = CLLocationCoordinate2D(
            latitude: (minLat + maxLat) / 2,
            longitude: (minLon + maxLon) / 2
        )

        let latDelta = max(0.02, (maxLat - minLat) * 1.25)
        let lonDelta = max(0.02, (maxLon - minLon) * 1.25)

        return MKCoordinateRegion(
            center: center,
            span: MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        )
    }

    private static let defaultRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 43.6047, longitude: 1.4442), // Toulouse fallback
        span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
    )
}

// MARK: - Helper models

private struct PendingPin {
    let id: UUID
    let title: String
    let addressString: String
}

private struct ActivityPin: Identifiable {
    let id: UUID
    let title: String
    let coordinate: CLLocationCoordinate2D
}

// MARK: - Address -> string for geocoding

private extension Address {
    /// Example: "10 Rue Alsace Lorraine, 31000, Toulouse"
    var geocodingString: String? {
        let parts = [street, postCode, city]
            .compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }

        guard !parts.isEmpty else { return nil }
        return parts.joined(separator: ", ")
    }
}

// MARK: - Async geocoding helper (works regardless of SDK async convenience availability)

private extension CLGeocoder {
    func geocode(_ addressString: String) async throws -> [CLPlacemark] {
        try await withCheckedThrowingContinuation { continuation in
            geocodeAddressString(addressString) { placemarks, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: placemarks ?? [])
                }
            }
        }
    }
}
*/


// v1
/*
import SwiftUI
import MapKit
import CoreLocation

/// Map view that geocodes each Activity.location (Address) and displays pins.
struct MapView: View {
    // previous version
    /*
    var results: [Activity]
    results = funvibes // This makes results tentatively the funvibes fake results [Activity] from AppData file
    */
    @State private var results: [Activity] = funvibes // Should this be private or public?

    @State private var region: MKCoordinateRegion = Self.defaultRegion
    @State private var pins: [ActivityPin] = []

    @State private var isGeocoding = false
    @State private var geocodeCache: [String: CLLocationCoordinate2D] = [:]   // addressString -> coordinate
    @State private var failedAddresses: [String] = []

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: pins) { pin in
            MapAnnotation(coordinate: pin.coordinate) {
                VStack(spacing: 2) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.red)

                    Text(pin.title)
                        .font(.caption2)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 3)
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .lineLimit(1)
                }
            }
        }
        .overlay(alignment: .top) {
            if isGeocoding {
                ProgressView("Locating activities…")
                    .padding(10)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.top, 12)
            } else if pins.isEmpty {
                Text("No mappable addresses in results.")
                    .padding(10)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.top, 12)
            }
        }
        .task(id: results.map(\.id)) {
            await geocodeAndBuildPins()
        }
        .overlay(alignment: .bottom) {
            if !failedAddresses.isEmpty {
                Text("Couldn’t locate \(failedAddresses.count) address(es).")
                    .font(.caption)
                    .padding(8)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.bottom, 12)
            }
        }
    }

    // MARK: - Geocoding

    private func geocodeAndBuildPins() async {
        // Build "pending pins" from results
        let pending: [PendingPin] = results.compactMap { activity in
            guard let addressString = activity.location.geocodingString else { return nil }
            return PendingPin(id: activity.id, title: activity.title, addressString: addressString)
        }

        guard !pending.isEmpty else {
            await MainActor.run {
                pins = []
                region = Self.defaultRegion
                failedAddresses = []
            }
            return
        }

        await MainActor.run { isGeocoding = true }

        let cacheSnapshot = await MainActor.run { geocodeCache }
        var localCache = cacheSnapshot
        var localFailed = Set<String>()

        let uniqueAddresses = Array(Set(pending.map(\.addressString))).sorted()
        let geocoder = CLGeocoder()

        for address in uniqueAddresses {
            if Task.isCancelled { break }
            if localCache[address] != nil { continue }

            do {
                let placemarks = try await geocoder.geocodeAddressString(address)
                if let coordinate = placemarks.first?.location?.coordinate {
                    localCache[address] = coordinate
                } else {
                    localFailed.insert(address)
                }
            } catch {
                localFailed.insert(address)
            }

            // small pacing helps avoid geocoder rate limiting if you have many results
            try? await Task.sleep(nanoseconds: 200_000_000)
        }

        let builtPins: [ActivityPin] = pending.compactMap { p in
            guard let c = localCache[p.addressString] else { return nil }
            return ActivityPin(id: p.id, title: p.title, coordinate: c)
        }

        let newRegion = regionToFit(builtPins.map(\.coordinate)) ?? Self.defaultRegion

        await MainActor.run {
            geocodeCache = localCache
            pins = builtPins
            region = newRegion
            failedAddresses = Array(localFailed).sorted()
            isGeocoding = false
        }
    }

    // MARK: - Region fitting

    private func regionToFit(_ coordinates: [CLLocationCoordinate2D]) -> MKCoordinateRegion? {
        guard let first = coordinates.first else { return nil }

        var minLat = first.latitude, maxLat = first.latitude
        var minLon = first.longitude, maxLon = first.longitude

        for c in coordinates.dropFirst() {
            minLat = min(minLat, c.latitude)
            maxLat = max(maxLat, c.latitude)
            minLon = min(minLon, c.longitude)
            maxLon = max(maxLon, c.longitude)
        }

        let center = CLLocationCoordinate2D(
            latitude: (minLat + maxLat) / 2,
            longitude: (minLon + maxLon) / 2
        )

        let latDelta = max(0.02, (maxLat - minLat) * 1.25)
        let lonDelta = max(0.02, (maxLon - minLon) * 1.25)

        return MKCoordinateRegion(
            center: center,
            span: MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        )
    }

    private static let defaultRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 43.6047, longitude: 1.4442), // Toulouse fallback
        span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
    )
}

// MARK: - Helper models

private struct PendingPin {
    let id: UUID
    let title: String
    let addressString: String
}

private struct ActivityPin: Identifiable {
    let id: UUID
    let title: String
    let coordinate: CLLocationCoordinate2D
}

// MARK: - Address formatting

private extension Address {
    /// Builds a string like "10 Rue Alsace Lorraine, 31000, Toulouse"
    var geocodingString: String? {
        let parts = [street, postCode, city]
            .compactMap { $0?.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }

        guard !parts.isEmpty else { return nil }
        return parts.joined(separator: ", ")
    }
}
*/







// v0
/*
import SwiftUI
import MapKit

// This View takes in the list results and shows them on the map.

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
*/

#Preview {
    MapView(results: funvibes)
}

