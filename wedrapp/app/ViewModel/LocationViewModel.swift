//
//  LocationViewModel.swift
//  weatherAppJunior
//
//  Created by ljanosova on 4.2.19.
//  Copyright © 2019 ljanosova. All rights reserved.
//

import Foundation
import CoreLocation
import ReactiveCocoa
import ReactiveSwift

final class LocationViewModel: NSObject {
    
    var userLocationCoordinates = MutableProperty<String?>(nil)
    var searchLocation = MutableProperty<String?>(nil)
    var userLocationName = MutableProperty<String?>(nil)
    var userLocationTapped = MutableProperty<Bool>(false)
    var locationManager = LocationManager()
    
    override init() {
        super.init()
        
        locationManager.locationManager.delegate = self
    }
}

extension LocationViewModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latitude = manager.location!.coordinate.latitude
        let longitude = manager.location!.coordinate.longitude
        userLocationCoordinates.value = locationManager.userLocationCoordinates(latitude,longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
}
