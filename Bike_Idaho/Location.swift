//
//  Location.swift
//  Bike_Idaho
//
//  Created by Joshua White on 5/29/16.
//  Copyright © 2016 Joshua White. All rights reserved.
//

import Foundation
import UIKit
import MapKit
/*
 Location Object. This stores a pin's Title, Description, Location and Image (if given).
 */
class Location: NSObject, MKAnnotation {
    /*
 "name":"Sawtooth Scenic Byway",
 "sealevel": "SawtoothElevation.png",
 "image": "SawtoothScenicBiway.jpg",
 "location": { "latitude":44.216335, "longitude":-114.930161 },
 "description":"Having the distinction of being the 100th National Forest Scenic Byway, Sawtooth Scenic Byway rolls north through fertile agricultural land then on through the resort towns of Hailey, Ketchum, and Sun Valley.",
 "website1":"https://visitidaho.org/things-to-do/scenic-byways-backcountry-drives/sawtooth-scenic-byway/",
 "website2":"http://idahoptv.org/outdoors/shows/scenicbyways/sawtooth.cfm",
 "distance":"117 miles",
 "youtube":"https://www.youtube.com/watch?v=ARNZP2he3MA",
 "endlocation": { "latitude": 42.935943, "longitude": -114.405878 },
 "routeimage": "SawtoothRoute.png",
 "directions":
 */
    var pinTitle:String = ""
    var pinDescription:String = ""
    var pinElevation:String = ""
    var pinImage:String = ""
    var pinLocation:CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: 0, longitude: 0)
    var pinWebsite1:String = ""
    var pinWebsite2:String = ""
    var pinDistance:String = ""
    var pinYoutube:String = ""
    var pinRoute:String = ""
    var pinDirections:String = ""
   // var pinImage = UIImage()
    
    init(pinTitle: String, pinDescription: String, pinElevation: String, pinImage: String, pinLocation: CLLocationCoordinate2D, pinWebsite1: String, pinWebsite2: String, pinDistance: String, pinYoutube: String, pinRoute: String, pinDirections: String) {
        self.pinTitle = pinTitle    //name
        self.pinDescription = pinDescription    //description
        self.pinLocation = pinLocation      //location
        self.pinElevation = pinElevation    //elevation
        self.pinImage = pinImage            //image
        self.pinWebsite1 = pinWebsite1
        self.pinWebsite2 = pinWebsite2
        self.pinDistance = pinDistance
        self.pinYoutube = pinYoutube
        self.pinRoute = pinRoute
        self.pinDirections = pinDirections
        super.init()
    }
    
    
    init(pinTitle: String, pinDescription: String, pinLocation: CLLocationCoordinate2D, pinImage: String) {
        self.pinTitle = pinTitle
        self.pinDescription = pinDescription
        self.pinLocation = pinLocation
        self.pinImage = pinImage
        super.init()
    }
    
    init(pinTitle: String, pinDescription: String, pinElevation: String, pinImage: String, pinLocation: CLLocationCoordinate2D)
    {
        self.pinTitle = pinTitle
        self.pinDescription = pinDescription
        self.pinElevation = pinElevation
        self.pinImage = pinImage
        self.pinLocation = pinLocation
        super.init()
    }
    
    
    var coordinate: CLLocationCoordinate2D {
        return pinLocation
    }
    
    
}