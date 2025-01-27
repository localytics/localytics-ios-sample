//
//  PlacesVM.swift
//  LocalyticsDemoApp
//
//  Created by Hitesh Rasal on 8/28/24.
//

import Foundation
import CoreLocation
import MapKit
import SwiftUI
import Localytics
import CoreLocation

@MainActor
final class PlacesVM: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    private let geocoder = CLGeocoder()
       @Published var userLocation: CLLocationCoordinate2D?
       @Published var locationName: String? = "Unknown"

    @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.457105, longitude: -80.508361), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))

    var binding: Binding<MKCoordinateRegion> {
        Binding {
            self.mapRegion
        } set: { newRegion in
            self.mapRegion = newRegion
        }
    }

    func checkIfLocationIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.delegate = self
            locationManager?.startUpdatingLocation()
        } else {
            print("Show an alert letting them know this is off")
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        Localytics.setLocationMonitoringEnabled(true)
        let previousAuthorizationStatus = manager.authorizationStatus
        manager.requestWhenInUseAuthorization()
        if manager.authorizationStatus != previousAuthorizationStatus {
            checkLocationAuthorization()
            if manager.authorizationStatus == .authorizedAlways {
                // start monitoring for geofences
            }
        }
    }

    private func checkLocationAuthorization() {
        guard let location = locationManager else {
            return
        }

        switch location.authorizationStatus {
        case .notDetermined:
            print("Location authorization is not determined.")
        case .restricted:
            print("Location is restricted.")
        case .denied:
            print("Location permission denied.")
        case .authorizedAlways, .authorizedWhenInUse:
            if let location = location.location {
                mapRegion = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            }

        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {
                DispatchQueue.main.async {
                    self.userLocation = location.coordinate
                    self.reverseGeocode(location: location)
                }
            }
        }
    
    // Reverse Geocoding function to get the location name
       private func reverseGeocode(location: CLLocation) {
           geocoder.reverseGeocodeLocation(location) { placemarks, error in
               if let placemark = placemarks?.first {
                   DispatchQueue.main.async {
                       self.locationName = (placemark.locality ?? "Unknown location") + (" \(placemark.subLocality ?? "")")
                       self.locationManager?.stopUpdatingLocation()
                   }
               } else {
                   self.locationName = "Unknown location"
               }
           }
       }
}

struct UserLocation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let name: String
}

extension CLLocationManager {
func locationServicesEnabledThreadSafe(completion: @escaping (Bool) -> Void) {
    DispatchQueue.global().async {
         let result = CLLocationManager.locationServicesEnabled()
         DispatchQueue.main.async {
            completion(result)
         }
      }
   }
}

