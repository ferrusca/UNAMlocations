//
//  ViewController.swift
//  locations
//
//  Created by 2020-1 on 11/4/19.
//  Copyright © 2019 ios. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        LocationManager.shared.requestAuthorization()
        let jsonData = try! JSONDecoder().decode(Locations.self, from: locationsData)
        print(jsonData)
    }
    
    
    


}

