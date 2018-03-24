//
//  MenuViewController.swift
//  Bike_Idaho
//
//  Created by Joshua White on 5/28/16.
//  Copyright © 2016 Joshua White. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UIViewController, GuillotineMenu {
    //GuillotineMenu protocol
    var dismissButton: UIButton!
    var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissButton = UIButton(frame: CGRectZero)
        dismissButton.setImage(UIImage(named: "ic_menu"), forState: .Normal)
        dismissButton.addTarget(self, action: #selector(MenuViewController.dismissButtonTapped(_:)), forControlEvents: .TouchUpInside)
        
        titleLabel = UILabel()
        titleLabel.numberOfLines = 1;
        titleLabel.text = "Bike Idaho"
        titleLabel.font = UIFont.boldSystemFontOfSize(17)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.sizeToFit()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("Menu: viewWillAppear")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("Menu: viewDidAppear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("Menu: viewWillDisappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("Menu: viewDidDisappear")
    }
    
    @IBAction func listButtonTapped(sender: AnyObject) {
        
        
        
    }
    func dismissButtonTapped(sende: UIButton) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
  

    struct parentName {
        static var parent = ""
    }

    @IBAction func menuButtonTapped(sender: UIButton) {
        print("Selected: " + sender.titleLabel!.text!)
        print(parentName.parent)
        if parentName.parent == sender.titleLabel!.text!
        {
            self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
            return
        }
        if sender.titleLabel!.text == "MAP"
        {
            let mapview =  self.storyboard?.instantiateViewControllerWithIdentifier("MapViewController") as! ViewController
            self.presentingViewController?.showViewController(mapview, sender: nil)
        }
        if sender.titleLabel!.text == "LIST"
        {
            let collectionview =  self.storyboard?.instantiateViewControllerWithIdentifier("CollectionViewController") as! CollectionViewController
            self.presentingViewController?.showViewController(collectionview, sender: nil)
        }
        if sender.titleLabel!.text == "LEARN MORE"
        {
            let learnview =  (self.storyboard?.instantiateViewControllerWithIdentifier("LEARNMORECONTROLLER"))! as UIViewController
            self.presentingViewController?.showViewController(learnview, sender: nil)
        }
        if sender.titleLabel!.text == "CREDITS"
        {
            let creditsview =  (self.storyboard?.instantiateViewControllerWithIdentifier("CREDITSCONTROLLER"))! as UIViewController
            self.presentingViewController?.showViewController(creditsview, sender: nil)
        }
        
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func closeMenu(sender: UIButton) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

extension MenuViewController: GuillotineAnimationDelegate {
    func animatorDidFinishPresentation(animator: GuillotineTransitionAnimation) {
        print("menuDidFinishPresentation")
    }
    func animatorDidFinishDismissal(animator: GuillotineTransitionAnimation) {
        print("menuDidFinishDismissal")
    }
    
    func animatorWillStartPresentation(animator: GuillotineTransitionAnimation) {
        print("willStartPresentation")
    }
    
    func animatorWillStartDismissal(animator: GuillotineTransitionAnimation) {
        print("willStartDismissal")
    }
}