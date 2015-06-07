//
//  LocationViewController.swift
//  MapSample
//
//  Created by Alexis Saint-Jean on 5/19/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//
//  Used code from http://www.veasoftware.com/tutorials/2015/5/12/current-location-in-swift-xcode-63-ios-83-tutorial


import UIKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!

    
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLabel.text = "Current Location:"
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
            if error != nil {
                println("Error: \(error.localizedDescription)")
                return
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as! CLPlacemark
                self.displayLocationInfo(pm)
            }
            
        })
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
        
        self.locationManager.stopUpdatingLocation()
        println(placemark.locality)
        println(placemark.postalCode)
        println(placemark.administrativeArea)
        println(placemark.country)
//        println(placemark.addressDictionary)
        
        self.cityLabel.text = "\(placemark.locality), \(placemark.postalCode) \(placemark.administrativeArea)"
        
        self.latitudeLabel.text = "\(placemark.thoroughfare)"
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error: \(error.localizedDescription)")
        self.titleLabel.text = "Error: " + error.localizedDescription
    }
    

    

}
