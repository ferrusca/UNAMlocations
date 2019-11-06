//
//  LocationsCodable.swift
//  locations
//
//  Created by 2020-1 on 11/4/19.
//  Copyright © 2019 ios. All rights reserved.
//

struct Locations: Codable {
    var locations: [Location]
}

struct Location: Codable {
    var lat: String
    var lng: String
    var title: String
    var subtitle: String
    var imagePath: String
}
