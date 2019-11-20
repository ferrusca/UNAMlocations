//
//  LocationManager.swift
//  locations
//
//  Created by 2020-1 on 11/4/19.
//  Copyright © 2019 ios. All rights reserved.
//

import CoreLocation
import UIKit
import MapKit

class LocationManager {
    
    var placemarks: [MKPlacemark?] = [nil, nil]
    
    let locationMgr = CLLocationManager()
    
    static let shared = LocationManager()
    
    private init(){        
        locationMgr.desiredAccuracy = kCLLocationAccuracyBest
        locationMgr.distanceFilter = kCLDistanceFilterNone
    }
    
    func requestAuthorization(){
        locationMgr.requestAlwaysAuthorization()
        locationMgr.startUpdatingLocation()
    }
    
    func addPlaceMark(index: Int, location: Location) {
        self.placemarks[index] = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: Double(location.lat)!, longitude: Double(location.lng)!))
    }
    
    func createAnnotation(_ location: Location) -> CustomAnnotation {
        return CustomAnnotation(title: location.title, subtitle: location.subtitle, imagePath: location.imagePath, location: CLLocationCoordinate2D(latitude: Double(location.lat)!, longitude: Double(location.lng)!))
    }
    
}
