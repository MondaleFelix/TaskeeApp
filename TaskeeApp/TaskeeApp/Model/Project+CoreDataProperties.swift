//
//  Project+CoreDataProperties.swift
//  TaskeeApp
//
//  Created by Mondale on 7/17/20.
//  Copyright © 2020 Mondale. All rights reserved.
//
//

import UIKit
import CoreData


extension Project {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Project> {
        return NSFetchRequest<Project>(entityName: "Project")
    }

    @NSManaged public var color: UIColor?
    @NSManaged public var name: String?
    @NSManaged public var relationship: NSSet?

}

// MARK: Generated accessors for relationship
extension Project {

    @objc(addRelationshipObject:)
    @NSManaged public func addToRelationship(_ value: Task)

    @objc(removeRelationshipObject:)
    @NSManaged public func removeFromRelationship(_ value: Task)

    @objc(addRelationship:)
    @NSManaged public func addToRelationship(_ values: NSSet)

    @objc(removeRelationship:)
    @NSManaged public func removeFromRelationship(_ values: NSSet)

}
