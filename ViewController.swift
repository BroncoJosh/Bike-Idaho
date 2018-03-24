//
//  ViewController.swift
//  Bike_Idaho
//
//  Created by Joshua White on 5/28/16.
//  Copyright © 2016 Joshua White. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreData

class ViewController: UIViewController, MKMapViewDelegate {
    
    
    @IBAction func setParent(sender: AnyObject) {
        
    }
    let reuseIdentifier = "ContentCell"
    @IBOutlet var mapView: MKMapView!
    private let cellHeight: CGFloat = 210
    private let cellSpacing: CGFloat = 20
    private lazy var presentationAnimator = GuillotineTransitionAnimation()
    
    @IBOutlet var barButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("VC: viewWillAppear")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("VC: viewDidAppear")
        MenuViewController.parentName.parent = "MAP"
        
        
        super.viewDidAppear(animated)
        DetailsViewController.parentName.parent = "ViewController"
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Building")
        
        //3
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            locations = results as! [NSManagedObject]
            viewDidLoad()
            //refreshMap(self)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("VC: viewWillDisappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("VC: viewDidDisappear")
    }
    
   
    
    let regionRadius: CLLocationDistance = 280000
   
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
 
    /*
     A function used for centering the Map object on the main page onto the user's location.
     */
    /*
    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius*2.0, regionRadius*2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    */
    @IBAction func showMenuAction(sender: UIButton) {
        let menuVC = storyboard!.instantiateViewControllerWithIdentifier("MenuViewController")
        menuVC.modalPresentationStyle = .Custom
        menuVC.transitioningDelegate = self
        if menuVC is GuillotineAnimationDelegate {
            presentationAnimator.animationDelegate = menuVC as? GuillotineAnimationDelegate
        }
        presentationAnimator.supportView = self.navigationController?.navigationBar
        presentationAnimator.presentButton = sender
        presentationAnimator.duration = 0.4
        self.presentViewController(menuVC, animated: true, completion: nil)
    }
    
    /*
     A function used for parsing JSON information into components of a Location Object.
     */
    func parseJSON(json: JSON) {
        for result in json.arrayValue {
            let pinDescription = result["description"].stringValue
            let pinTitle = result["name"].stringValue
            let pinElevation = result["sealevel"].stringValue
            let pinImage = result["image"].stringValue
            let pinLocation = CLLocationCoordinate2D(latitude: result["location"]["latitude"].doubleValue, longitude: result["location"]["longitude"].doubleValue)
            let pinWebsite1 = result["website1"].stringValue
            let pinWebsite2 = result["website2"].stringValue
            let pinDistance = result["distance"].stringValue
            let pinYoutube = result["youtube"].stringValue
            let pinRoute = result["routeimage"].stringValue
            let pinDirections = result["directions"].stringValue
         //   let newLocation = Location(pinTitle: pinTitle, pinDescription: pinDescription, pinElevation: pinElevation, pinImage: pinImage,  pinLocation: pinLocation)
            
            let newLocation = Location(pinTitle: pinTitle, pinDescription: pinDescription, pinElevation: pinElevation, pinImage: pinImage, pinLocation: pinLocation, pinWebsite1: pinWebsite1, pinWebsite2: pinWebsite2, pinDistance: pinDistance, pinYoutube: pinYoutube, pinRoute: pinRoute, pinDirections: pinDirections)
            
            if LocationController.locationsArray.contains({Location in Location.pinTitle == newLocation.pinTitle})
            {

            }
            else
            {
                print(newLocation.pinTitle)
                LocationController.locationsArray.addObject(newLocation)
            }
        }
    }
    
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        //DetailsViewController.itemNumber.item = indexPath.row
        for i in 0...(LocationController.locationsArray.count - 1) {
            if LocationController.locationsArray[i].pinTitle == ((view.annotation?.title)!)! as String
            {
                DetailsViewController.itemNumber.item = i
            }
        }
        print("Hey")
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("MoreDetails")
        self.showViewController(vc as! UIViewController, sender: vc)
    }
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
                var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier("pin")
        
        if pinView == nil {

            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            pinView!.canShowCallout = true
            //pinView!.canShowCallout = false
            
            // Add image to left callout
            let pinImage = UIImage(named: "CustomPin2.png")
            let size = CGSize(width: 70, height: 70)
            UIGraphicsBeginImageContext(size)
            pinImage!.drawInRect(CGRectMake(0, 0, size.width, size.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            pinView?.image = resizedImage
            //pinView!.leftCalloutAccessoryView = mugIconView
            
            
            
            // Add detail button to right callout
            let calloutButton = UIButton(type: .DetailDisclosure) as UIButton
            pinView!.rightCalloutAccessoryView = calloutButton
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    
    static var initialLocation = CLLocationCoordinate2D()
    var locations = [NSManagedObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navBar = self.navigationController!.navigationBar
        navBar.barTintColor = UIColor(red: 65.0 / 255.0, green: 62.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        // Set Default Map Load Location to Idaho
        let initialLocation = CLLocation(latitude: 45.5, longitude: -114)
        centerMapOnLocation(initialLocation)
        
        mapView.delegate = self
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext: NSManagedObjectContext = appDelegate.managedObjectContext
        
       
        if let path = NSBundle.mainBundle().pathForResource("Biways", ofType: "json")
        {
           if let jsonData = NSData(contentsOfFile: path)
           {
                let json = JSON(data: jsonData)
                parseJSON(json)
           }
        }
            
       
  //      for (var index = 0; index < LocationController.locationsArray.count; index += 1)
        for index in 0...(LocationController.locationsArray.count-1)
        {
            var contained = false
            let currentLocation = LocationController.locationsArray[index] as! Location
            let pin = MKPointAnnotation()
            pin.title = currentLocation.pinTitle
            pin.subtitle = currentLocation.pinDistance
            pin.coordinate = currentLocation.pinLocation
            
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            
            let fetchRequest = NSFetchRequest(entityName: "Building")
            do {
                
                let fetchResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
                let entity = NSEntityDescription.entityForName("Building", inManagedObjectContext: managedContext)
                
                let build = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
                //let build = NSManagedObject()
                //3
                build.setValue(pin.title, forKey: "BuildingName")
                build.setValue(pin.subtitle, forKey: "subtitle")
                build.setValue(pin.coordinate.latitude, forKey: "latitude")
                build.setValue(pin.coordinate.longitude, forKey: "longitude")
                
                for res: AnyObject! in fetchResults!
                {
                    if(res.valueForKey("BuildingName")as? String == pin.title)
                    {
                        contained = true
                        managedContext.reset()
                        break
                    }
                    
                    
                }
                if(contained == false)
                {
                    do {
                        try managedContext.save()
                        //5
                        
                        locations.append(build)
                    } catch let error as NSError  {
                        print("Could not save \(error), \(error.userInfo)")
                    }
                }
                
            } catch {
                
                print("Could not fetch")
            }
  
            
        }
        
        
        
        LocationController.startReportingLocation()
        
        //let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Building")
        
        do {
            let fetchResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            for res: AnyObject! in fetchResults!
            {
                
                //Use Core Data to add pins
                let pin = MKPointAnnotation()
                pin.title = res.valueForKey("BuildingName")as? String
                pin.subtitle = res.valueForKey("subtitle")as? String
                let temparea = CLLocationCoordinate2D(latitude: (res.valueForKey("latitude")as? Double)!, longitude: (res.valueForKey("longitude")as? Double!)!)
                pin.coordinate = temparea
              //  mapView2(mapView, viewForAnnotation: pin).annotation = pin
                mapView.addAnnotation( pin)
                
                
            }
        }catch {
            
            print("Could not fetch")
        }
        
        
        
        /*
         //Old Method of adding pins (Not using core data)
         for (var index = 0; index < LocationController.locationsArray.count; index++)
         {
         
         let currentLocation = LocationController.locationsArray[index] as! Location
         let pin = MKPointAnnotation()
         pin.title = currentLocation.pinTitle
         pin.subtitle = currentLocation.pinDescription
         pin.coordinate = currentLocation.pinLocation
         mapView.addAnnotation( pin)
         }
         */
    }
    
    
    func inputIntoDB(loc: Location)
    {
        var contained = false
        let currentLocation = loc
        let pin = MKPointAnnotation()
        pin.title = currentLocation.pinTitle
        pin.subtitle = currentLocation.pinDescription
        pin.coordinate = currentLocation.pinLocation
        
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Building")
        do {
            
            let fetchResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            
            let entity = NSEntityDescription.entityForName("Building", inManagedObjectContext: managedContext)
            
            let build = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
            //let build = NSManagedObject()
            //3
            build.setValue(pin.title, forKey: "BuildingName")
            build.setValue(pin.subtitle, forKey: "subtitle")
            build.setValue(pin.coordinate.latitude, forKey: "latitude")
            build.setValue(pin.coordinate.longitude, forKey: "longitude")
            
            
            for res: AnyObject! in fetchResults!
            {
                if(res.valueForKey("BuildingName")as? String == pin.title)
                {
                    contained = true
                    managedContext.reset()
                    break
                }
                
                
            }
            if(contained == false)
            {
                do {
                    try managedContext.save()
                    //5
                    
                    locations.append(build)
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                }
            }
            
        } catch {
            
            print("Could not fetch")
        }
        
    }
    
    
        
        
        
        
    }




extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .Presentation
        return presentationAnimator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .Dismissal
        return presentationAnimator
    }
}

