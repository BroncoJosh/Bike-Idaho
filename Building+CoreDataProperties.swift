//
//  Building+CoreDataProperties.swift
//  Project1
//
//  Created by Josh White on 11/30/15.
//  Copyright © 2015 Josh White. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Building {
    
    @NSManaged var buildingName: String?
    @NSManaged var subtitle: String?
    @NSManaged var longitude: NSNumber?
    @NSManaged var latitude: NSNumber?
    @NSManaged var buildingLocation: BuildingLocation?
    
}