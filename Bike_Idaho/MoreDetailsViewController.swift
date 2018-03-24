//
//  MoreDetailsViewController.swift
//  Bike_Idaho
//
//  Created by Joshua White on 6/5/16.
//  Copyright © 2016 Joshua White. All rights reserved.
//

import Foundation
import UIKit

class MoreDetailsViewController: UIViewController
{
    @IBOutlet weak var routeImage: UIImageView!
    
    //@IBOutlet weak var elevationImage: UIImageView!
    
    @IBOutlet weak var bywayName2: UITextView!
    @IBOutlet weak var bywayName: UITextView!
    @IBOutlet weak var directions: UITextView!
    
    @IBOutlet weak var elevation: UIImageView!
    @IBOutlet weak var bywayDescription: UITextView!
    
    @IBOutlet weak var bywayImage: UIImageView!
    @IBOutlet weak var website1: UITextView!
    @IBOutlet weak var website2: UITextView!
    @IBOutlet weak var youtube: UITextView!
 /*
    override func viewDidAppear(animated: Bool) {
        //super.viewDidAppear(animated)
         print("MoreDetails didAppear")
       

    }
   */
    
    override func viewDidLoad() {
        super.viewDidLoad()
               // cell.imageView?.image = UIImage(named: tempLocation.pinImage)
     let tempLocation = LocationController.locationsArray[DetailsViewController.itemNumber.item] as! Location
     print(DetailsViewController.itemNumber.item)
     bywayName?.text = tempLocation.pinTitle
     bywayName2?.text = tempLocation.pinTitle
     bywayImage?.image = UIImage(named: tempLocation.pinImage)
     bywayDescription?.text = tempLocation.pinDescription
     routeImage?.image = UIImage(named: tempLocation.pinRoute)
     elevation?.image = UIImage(named: tempLocation.pinElevation)
     directions?.text = tempLocation.pinDirections
     website1?.text = tempLocation.pinWebsite1
     website2?.text = tempLocation.pinWebsite2
     youtube?.text = tempLocation.pinYoutube
    
    }

   
    
}