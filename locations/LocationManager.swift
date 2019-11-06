//
//  LocationManager.swift
//  locations
//
//  Created by 2020-1 on 11/4/19.
//  Copyright © 2019 ios. All rights reserved.
//

import CoreLocation
import UIKit

class LocationManager {
    
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

    
}
