//
//  LocationManager.swift
//  weatherAppJunior
//
//  Created by ljanosova on 10.1.19.
//  Copyright © 2019 ljanosova. All rights reserved.
//

import CoreLocation

final class LocationManager {
    
    var locationManager: CLLocationManager!
    
    init() {
        locationManager = CLLocationManager()
    }
    
    func determineUserLocation() {
    
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func userLocationCoordinates(_ latitude: Double?, _ longitude: Double?) -> String {
        
        return "lat=\(latitude ?? -1000000)&lon=\(longitude ?? -1000000)"
    }

}
