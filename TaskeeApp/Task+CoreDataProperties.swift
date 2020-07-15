//
//  Task+CoreDataProperties.swift
//  TaskeeApp
//
//  Created by Mondale on 7/15/20.
//  Copyright © 2020 Mondale. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var dueDate: Date?
    @NSManaged public var status: Bool
    @NSManaged public var title: String?
    @NSManaged public var relationship: Project?

}
