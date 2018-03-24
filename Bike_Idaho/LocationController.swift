//
//  LocationController.swift
//  Bike_Idaho
//
//  Created by Joshua White on 5/29/16.
//  Copyright © 2016 Joshua White. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class LocationController: NSObject, CLLocationManagerDelegate
{
    static var locationController = LocationController() //Object that points to LocationController class
    
    static var locationsArray = NSMutableArray()    //Used for storing all of the pin Locatin objects
    
    
    let locationManager:CLLocationManager = CLLocationManager() //Creates the CLLocationManager Object.
    
    /*
     Function that starts retrieving the user location.
     */
    class func startReportingLocation()
    {
        locationController.locationManager.startUpdatingLocation()
    }
    
    /*
     Function that stops retrieving the user location. Not used.
     */
    class func stopReportingLocation()
    {
        
    }
    
    
    /*
     Init function. Respecifies what should be initialized on start of LocationController.
     */
    /*
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.distanceFilter = 100.0
        if #available(iOS 8.0, *) {
            locationManager.requestAlwaysAuthorization()
            
        } else {
            if #available(iOS 9.0, *) {
                locationManager.requestLocation()
            } else {
                //I would need a way to retrieve location for iOS 7.0
                // Fallback on earlier versions
            }
            // Fallback on earlier versions
        }
        
    }
    */
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        //print(status)
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        ViewController.initialLocation = CLLocationCoordinate2D(latitude: newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude)
        //print(newLocation)
    }
    
    
    
}