//
//  CoreDataStack.swift
//  ProjectFitry
//
//  Created by Faannaka on 26.04.17.
//  Copyright © 2017 Anar Baghirov. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataStack {
    private init() { }
    
    static let shared = CoreDataStack()
    
    fileprivate lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ProjectFitry")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

extension CoreDataStack {
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func create<T: NSManagedObject>(_ type: T.Type) -> T {
        return T(context: persistentContainer.viewContext)
    }
    
    func fetchedObjects<T>(controller: NSFetchedResultsController<T>) -> [T] {
        do {
            try controller.performFetch()
            if let objects = controller.fetchedObjects {
                return objects
            }
        } catch {
            
        }
        
        return []
    }
    
    func fetchedResultController<T: NSManagedObject>(_ type: T.Type,
                                 sort: [NSSortDescriptor],
                                 sectionNameKeyPath: String? = nil,
                                 cacheName: String? = nil) -> NSFetchedResultsController<T> {
        let fetchRequest = T.fetchRequest() as! NSFetchRequest<T>
        fetchRequest.sortDescriptors = sort
        
        return NSFetchedResultsController(fetchRequest: fetchRequest,
                                          managedObjectContext: persistentContainer.viewContext,
                                          sectionNameKeyPath: sectionNameKeyPath,
                                          cacheName: cacheName)
    }
}
