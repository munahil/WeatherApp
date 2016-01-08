//
//  MapViewController.swift
//  WeatherApp
//
//  Created by Munahil Murrieum on 31/12/2015.
//  Copyright © 2015 Munahil Murrieum. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
  
    @IBOutlet weak var mapView: MKMapView!
    let anotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func revealRegionDetailsWithLongPressOnMap(sender: UILongPressGestureRecognizer) {
        if sender.state != UIGestureRecognizerState.Began { return }
        let touchLocation = sender.locationInView(mapView)
        let locationCoordinate = mapView.convertPoint(touchLocation, toCoordinateFromView: mapView)
        print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
        
        let newCoord:CLLocationCoordinate2D = mapView.convertPoint(touchLocation, toCoordinateFromView: self.mapView)
        
        self.weatherForCurrentLatLon("\(locationCoordinate.latitude)",lon: "\(locationCoordinate.longitude)", newCoord: newCoord)
        
    }
    
    func weatherForCurrentLatLon(lat: String, lon: String, newCoord:CLLocationCoordinate2D )
    {
        DataManager.api_openWeatherMap_currentLatLon(lat, lon: lon) { (result) in
            guard let weatherResult = result else { return }
            dispatch_async(dispatch_get_main_queue()) { () in
                self.anotation.title = "\(weatherResult.temperature)"
                self.anotation.subtitle = "\(weatherResult.weatherInWords)"
                
                self.anotation.coordinate = newCoord
                self.mapView.addAnnotation(self.anotation)
                
            }
        }
    }
    
    // MARK:
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

