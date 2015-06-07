//
//  LocMapViewController.swift
//  MapSample
//
//  Created by Alexis Saint-Jean on 5/31/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class LocMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var locationUpdateInfoLabel: UILabel!
    let locationManager = CLLocationManager()
    var loopChanges = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("Start of viewDidLoad")

        //Set up our Location Manager
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        //Set up our Map View
        self.map.delegate = self
        self.map.showsUserLocation = true
        
        println("End of viewDidLoad")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        loopChanges += 1
        println("Identified a change in current location \(loopChanges)")
        self.locationUpdateInfoLabel.text = "Identified a change in current location \(loopChanges)"
        
        let location = locations.last as! CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.map.setRegion(region, animated: true)
    }

}
