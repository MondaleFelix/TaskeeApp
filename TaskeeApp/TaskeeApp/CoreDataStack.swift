//
//  CoreDataStack.swift
//  TaskeeApp
//
//  Created by Mondale on 7/15/20.
//  Copyright © 2020 Mondale. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    private let modelName: String //create a private property to store the modelName
    
    //we always need this
    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    //    modelName: String
    
    private init() {
        self.modelName = "TaskeeApp" //initializer needed to save the modelName into the private property
    }
    
    //lazy instantiate the NSPersistentContainer, passing the modelName
    private lazy var storeContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores {(storeDescription, error) in
            if let error = error as NSError? {
                print("Error: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    //MARK: Save
    func saveContext () {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
    
    //MARK: Fetch Tasks

    
}
