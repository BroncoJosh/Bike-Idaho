//
//  DataSource.swift
//  Bike_Idaho
//
//  Created by Joshua White on 6/3/16.
//  Copyright © 2016 Joshua White. All rights reserved.
//

import Foundation
import UIKit
import MapKit


class DataSource {
    
    init() {
        populateData()
    }
    
    var locations:[Location] = []
  
    
    // MARK:- Populate Data from plist
    
    func populateData() {
        if let path = NSBundle.mainBundle().pathForResource("Biways", ofType: "json")
        {
            if let jsonData = NSData(contentsOfFile: path)
            {
                let json = JSON(data: jsonData)
                parseJSON(json)
            }
        }
    }
    
    func parseJSON(json : JSON)
    {
        for result in json.arrayValue {
            print("Heyo!!!")
            let pinDescription = result["description"].stringValue
            let pinElevation = result["sealevel"].stringValue
            let pinTitle = result["name"].stringValue
            let pinImage = result["image"].stringValue
            let pinLocation = CLLocationCoordinate2D(latitude: result["location"]["latitude"].doubleValue, longitude: result["location"]["longitude"].doubleValue)
            let pinWebsite1 = result["website1"].stringValue
            let pinWebsite2 = result["website2"].stringValue
            let pinDistance = result["distance"].stringValue
            let pinYoutube = result["youtube"].stringValue
            let pinRoute = result["routeImage"].stringValue
            let pinDirections = result["directions"].stringValue
            
            //let newLocation = Location(pinTitle: pinTitle, pinDescription: pinDescription, pinElevation: pinElevation, pinImage: pinImage, pinLocation: pinLocation)
           
            let newLocation = Location(pinTitle: pinTitle, pinDescription: pinDescription, pinElevation: pinElevation, pinImage: pinImage, pinLocation: pinLocation, pinWebsite1: pinWebsite1, pinWebsite2: pinWebsite2, pinDistance: pinDistance, pinYoutube: pinYoutube, pinRoute: pinRoute, pinDirections: pinDirections)
            
            
            if LocationController.locationsArray.contains({Location in Location.pinTitle == newLocation.pinTitle})
            {
                
            }
            else
            {
                LocationController.locationsArray.addObject(newLocation)
            }
        }
    }
    
    
}