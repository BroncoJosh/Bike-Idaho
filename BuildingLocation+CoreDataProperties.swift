//
//  BuildingLocation+CoreDataProperties.swift
//  Project1
//
//  Created by Josh White on 11/29/15.
//  Copyright © 2015 Josh White. All rights reserved.
//

import Foundation
import CoreData

extension BuildingLocation {
    
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var building: NSSet?
    
}