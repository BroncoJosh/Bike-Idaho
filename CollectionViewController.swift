//
//  CollectionViewController.swift
//  Bike_Idaho
//
//  Created by Joshua White on 5/30/16.
//  Copyright © 2016 Joshua White. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreData

class CollectionViewController: UITableViewController {
    
    let reuseIdentifier = "ContentCell"
    private let cellHeight: CGFloat = 210
    private let imageHeight: CGFloat = 180
    private let cellSpacing: CGFloat = 20
    private lazy var presentationAnimator = GuillotineTransitionAnimation()
    static var cellsArray = [false, false, false, false, false, false, false, false, false, false,
                             false, false, false, false, false, false, false, false, false, false,
                             false, false, false, false, false, false, false, false, false, false,
                             false, false]
    
    @IBOutlet weak var barButton: UIButton!
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocationController.locationsArray.count
        //return 32
    }
    
    
    override func tableView(tableView2: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        let tempLocation = LocationController.locationsArray[indexPath.item] as! Location
        
        cell.textLabel?.text = tempLocation.pinTitle
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.backgroundColor = UIColor(red: 65.0 / 255.0, green: 62.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        cell.detailTextLabel?.text = "Length: " + tempLocation.pinDistance
        cell.detailTextLabel?.textColor = UIColor.whiteColor()
        cell.detailTextLabel?.backgroundColor = UIColor(red: 65.0 / 255.0, green: 62.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        cell.imageView?.image = UIImage(named: tempLocation.pinImage)
        
    
        if CollectionViewController.cellsArray[indexPath.item] == false
        {
            CollectionViewController.cellsArray[indexPath.item] = true
            return cell
        }
        return cell
    }
 /*
    func tableView(tableView: UITableView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: AnyObject? = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath)
        return cell as! UITableViewCell!
    }
 */
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
        DetailsViewController.itemNumber.item = indexPath.row
        
        let vc : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("MoreDetails")
        self.showViewController(vc as! UIViewController, sender: vc)
        //detailsview.loadView()
        //self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        print("CV: viewWillAppear")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("CV: viewDidAppear")
        MenuViewController.parentName.parent = "LIST"
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("CV: viewWillDisappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("CV: viewDidDisappear")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CV: viewDidLoad")
        let navBar = self.navigationController!.navigationBar
        navBar.barTintColor = UIColor(red: 65.0 / 255.0, green: 62.0 / 255.0, blue: 79.0 / 255.0, alpha: 1)
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        
        if let path = NSBundle.mainBundle().pathForResource("Biways", ofType: "json")
        {
            if let jsonData = NSData(contentsOfFile: path)
            {
                let json = JSON(data: jsonData)
                parseJSON(json)
            }
        }
        
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

    
    
    @IBAction func showMenu(sender: UIButton) {
        let menuVC = storyboard!.instantiateViewControllerWithIdentifier("MenuViewController")
        menuVC.modalPresentationStyle = .Custom
        menuVC.transitioningDelegate = self
        if menuVC is GuillotineAnimationDelegate {
            presentationAnimator.animationDelegate = menuVC as? GuillotineAnimationDelegate
        }
        presentationAnimator.supportView = self.navigationController?.navigationBar
        presentationAnimator.presentButton = sender
        presentationAnimator.duration = 0.6
        self.presentViewController(menuVC, animated: true, completion: nil)
    }


}

extension CollectionViewController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .Presentation
        return presentationAnimator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .Dismissal
        return presentationAnimator
    }
}
