//
//  DetailsViewController.swift
//  Bike_Idaho
//
//  Created by Joshua White on 5/29/16.
//  Copyright © 2016 Joshua White. All rights reserved.
//

import Foundation
import UIKit
import MapKit

/*
 View Controller for the second View for this app. Retrieves a Title, Description and Image from
 a user, then places that information into a pin on the Map.
 */
class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    // MARK: Variable Declarations
    @IBOutlet weak var titleTextfield: UITextField! //Outlet for the title Text field
    @IBOutlet weak var descriptionTextfield: UITextField!   //Outlet for the description Text field
    @IBOutlet weak var imageView: UIImageView!  //Outlet for the image on the App View.
    @IBOutlet weak var CloseView: UIBarButtonItem!
    
    
    @IBAction func RemoveCurrentView(sender: AnyObject) {
    }
    
    @IBAction func CloseView(sender: AnyObject) {
        print(parentName.parent)
        [self.dismissViewControllerAnimated(true, completion: {})]
        if (parentName.parent == "ViewController")
        {
            
        }
        
    }
    
    struct parentName {
        static var parent = ""
    }
    
    struct itemNumber {
        static var item = 0
    }
    
    //MARK: Image Functionality
    /*
     Function for when the Camera/Library button is pressed. Allows the user to select an image from
     their library.
     */
    @IBAction func showLibraryAction(sender: AnyObject) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        if( UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
        {
            imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
        }
        else
        {
            imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        imagePickerController.allowsEditing = true
        
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    /*
     Function for setting the imageView image to the User's image that they picked.
     */
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!)
        
    {
        imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    /*
     Function for clearing the image from the app View. Set's it to nil.
     */
    @IBAction func clearImage(sender: UIButton) {
        imageView.image = nil
        
    }
    
    // MARK: Save Button
    /*
     Function for when Save Button is pressed.
     */
    @IBAction func onSave(sender: UIButton) {
        let title = titleTextfield!.text    //Setting title to a constant
        let descriptionString = descriptionTextfield!.text  //Setting description to a constant
        let currentLocationCoordinate = ViewController.initialLocation  //Setting current location to a constant
        let img = imageView.image   //Setting image to a constant
        let elevation = "0"
        let pinImage = ""
        let currentLocation = Location(pinTitle: title!, pinDescription: descriptionString!, pinElevation: elevation, pinImage: pinImage, pinLocation: currentLocationCoordinate)    //Creating a Location object (not including an image)
        
        
        
        if (img != nil){    //If there was an image chosen....
        //    currentLocation = Location(pinTitle: title!, pinDescription: descriptionString!, pinLocation: currentLocationCoordinate, pinImage: img!) //Update the Location object to contain an image too.
        }
        currentLocation.pinDescription = descriptionString! //Set Location objects Description.
        currentLocation.pinTitle = title!   //Set Location objects Title.
        currentLocation.pinLocation = currentLocationCoordinate //Set Location objects Location.
        if (img != nil){
           // currentLocation.pinImage = img! //Set Location objects Image.
        }
        LocationController.locationsArray.addObject(currentLocation)    //Add the Location Object to the locationsArray array.
        self.navigationController?.popViewControllerAnimated(true)
        
        let vc = ViewController()
        vc.inputIntoDB(currentLocation)
        //TODO ==================== Input into core data here ===================
        
    }
    
}