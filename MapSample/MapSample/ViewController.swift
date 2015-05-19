//
//  ViewController.swift
//  MapSample
//
//  Created by Alexis Saint-Jean on 4/29/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBAction func ZoomIn(sender: AnyObject) {
        let userLocation = mapView.userLocation
        
        let region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 40000, 40000)
        
        mapView.setRegion(region, animated: true)
        
    }
    @IBAction func changeMapType(sender: AnyObject) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        self.locationManager?.delegate = self
        
        self.mapView.delegate = self
        
//        let userLocation = mapView.userLocation
//        
//        println("user Location's longitude is: \(userLocation.coordinate.longitude) and latitude: \(userLocation.coordinate.latitude)")
        
//        let region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 80000, 80000)
        
    }
    
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        println("locationManager()")
        switch status {
        case CLAuthorizationStatus.AuthorizedWhenInUse:
            manager.startUpdatingLocation()
            self.mapView.showsUserLocation = true
        default: break
        }
    }
    
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        println("mapView()")
        let userLocation = mapView.userLocation
        
        println("user Location's longitude is: \(userLocation.coordinate.longitude) and latitude: \(userLocation.coordinate.latitude)")
        
        self.locationLabel.text = "longitude: \(userLocation.coordinate.longitude) | latitude: \(userLocation.coordinate.latitude)"
        
        let region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 10000, 10000)
        self.mapView.setRegion(region, animated: true)
        // Not getting called
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

