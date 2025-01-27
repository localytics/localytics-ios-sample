//
//  PlacesVw.swift
//  LocalyticsDemoApp
//
//  Created by Hitesh Rasal on 8/21/24.
//

import SwiftUI
import MapKit
import CoreLocation
import Localytics


struct PlacesVw: View {
    
    @StateObject var viewModel = PlacesVM()
    
    var body: some View {
        VStack {
            if let coordinate = viewModel.userLocation, let locationName = viewModel.locationName {
                Map(coordinateRegion: viewModel.binding,
                    showsUserLocation: true,
                    userTrackingMode: .constant(.follow),
                    annotationItems: [UserLocation(coordinate: coordinate, name: locationName)]) { place in
                    MapAnnotation(coordinate: place.coordinate) {
                        VStack {
                            Text(place.name)
                                .font(.caption)
                                .bold()
                                .padding(5)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 3)
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.red)
                                .font(.title)
                        }
                    }
                }
                    .edgesIgnoringSafeArea(.all)
                    .onAppear(perform: {
                        viewModel.checkIfLocationIsEnabled()
                        Localytics.persistLocationMonitoring(true)
                        Localytics.setLocationMonitoringEnabled(true)
                    })
                
            } else {
                Map(coordinateRegion: viewModel.binding,
                    showsUserLocation: true,
                    userTrackingMode: .constant(.follow))
                .edgesIgnoringSafeArea(.all)
                .onAppear(perform: {
                    viewModel.checkIfLocationIsEnabled()
                    Localytics.persistLocationMonitoring(true)
                    Localytics.setLocationMonitoringEnabled(true)
                    Localytics.tagScreen("Places Screen")
                })
            }
        }
        
    }
}





struct PlacesVw_Previews: PreviewProvider {
    static var previews: some View {
        PlacesVw()
    }
}
