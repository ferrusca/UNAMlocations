//
//  ViewController.swift
//  locations
//
//  Created by 2020-1 on 11/4/19.
//  Copyright © 2019 ios. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var sourceTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var myMap: MKMapView!
    
    
    var jsonData: Locations!
    
    @IBAction func calculateRoute(_ sender: UIButton) {
        let routeRequest = MKDirections.Request();
        routeRequest.source = MKMapItem(placemark: LocationManager.shared.placemarks[0]!)
        routeRequest.destination = MKMapItem(placemark: LocationManager.shared.placemarks[1]!)
        routeRequest.transportType = .walking
        
        let directions = MKDirections(request: routeRequest);
        
        directions.calculate { (response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let directionsResponse = response else {
                return
            }
            let route = directionsResponse.routes[0]
            self.myMap.removeOverlays(self.myMap.overlays)
            self.myMap.addOverlay(route.polyline)
            
            // Create area between A and B point
            let area = route.polyline.boundingMapRect
            self.myMap.setRegion(MKCoordinateRegion(area), animated: true)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myMap.delegate = self
        sourceTextField.addTarget(self, action: #selector(showSourceOptions), for: .touchDown)
        destinationTextField.addTarget(self, action: #selector(showDestinationOptions), for: .touchDown)
        LocationManager.shared.requestAuthorization()
        if let url = Bundle.main.url(forResource: "Locations", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let jsonData = try JSONDecoder().decode(Locations.self, from: data)
                print(jsonData)
                self.jsonData = jsonData
            } catch {
                print("error:\(error)");
            }
        }
    }
    
    
    @objc func showSourceOptions(textField: UITextField) {
        print(textField)
        let alert = UIAlertController(title: "Origen", message: "Selecciona un punto de partida", preferredStyle: .actionSheet)
        for place in self.jsonData.locations {
            alert.addAction(UIAlertAction(title: place.title, style: .default , handler:{ (UIAlertAction)in
                textField.text = "\(place.title), \(place.subtitle)."
                LocationManager.shared.addPlaceMark(index: 0, location: place)
                self.myMap.addAnnotation(LocationManager.shared.createAnnotation(place))
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancelar", style: .default , handler:{ (UIAlertAction)in
            print("Cancel")
        }))
        present(alert, animated: true)
    }
    
    @objc func showDestinationOptions(textField: UITextField) {
        let alert = UIAlertController(title: "Destino", message: "Selecciona un punto de destino", preferredStyle: .actionSheet)
        for place in self.jsonData.locations {
            alert.addAction(UIAlertAction(title: place.title, style: .default , handler:{ (UIAlertAction)in
                textField.text = "\(place.title), \(place.subtitle)."
                LocationManager.shared.addPlaceMark(index: 1, location: place)
                self.myMap.addAnnotation(LocationManager.shared.createAnnotation(place))
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancelar", style: .default , handler:{ (UIAlertAction)in
            print("Cancel")
        }))
        present(alert, animated: true)
    }

    // When an overlay is added (addOverlay()), this method is called
    // Or when location is updated
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let line = MKPolylineRenderer(overlay: overlay)
        line.strokeColor = UIColor(red: 0/255, green: 132/255, blue: 8/255, alpha: 1.0)
        line.lineWidth = 6.0
        return line
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pinAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "PinAnnotationView")
        pinAnnotationView.canShowCallout = true
        if let pinAnnotation = annotation as? CustomAnnotation {
            pinAnnotationView.image = UIImage(named: pinAnnotation.imagePath)
        }
        return pinAnnotationView
    }
}

