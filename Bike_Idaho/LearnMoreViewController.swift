//
//  LearnMoreViewController.swift
//  Bike_Idaho
//
//  Created by Joshua White on 6/4/16.
//  Copyright © 2016 Joshua White. All rights reserved.
//

import Foundation
import UIKit

class LearnMoreViewController: UIViewController {
    
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

extension LearnMoreViewController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .Presentation
        return presentationAnimator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator.mode = .Dismissal
        return presentationAnimator
    }
}
