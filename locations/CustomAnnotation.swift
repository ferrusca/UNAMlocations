//
//  CustomAnnotation.swift
//  locations
//
//  Created by 2020-1 on 11/13/19.
//  Copyright © 2019 ios. All rights reserved.
//

import Foundation
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    var imagePath: String = "default.png";
    
    init(title: String, subtitle: String, imagePath: String, location: CLLocationCoordinate2D) {
        self.title = title;
        self.subtitle = subtitle;
        self.coordinate = location;
        self.imagePath = imagePath;
    }
    
}
