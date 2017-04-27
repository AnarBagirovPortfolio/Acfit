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
    
    enum ObjectKind {
        case calendar
        case completeExersice
        case customer
        case exercise
        case muscle
        case tool
        case weightLog
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
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
    
    func fetchedResultController<T: NSManagedObject>(_ type: T.Type, sort: [NSSortDescriptor]) -> NSFetchedResultsController<T> {
        let fetchRequest = T.fetchRequest() as! NSFetchRequest<T>
        fetchRequest.sortDescriptors = sort
        
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    func create(_ kind: CoreDataStack.ObjectKind) -> NSManagedObject {
        switch kind {
        case .calendar:
            return Calendar(context: context)
        case .completeExersice:
            return CompleteExercise(context: context)
        case .customer:
            return Customer(context: context)
        case .exercise:
            return Exercise(context: context)
        case .muscle:
            return Muscle(context: context)
        case .tool:
            return Tool(context: context)
        case .weightLog:
            return WeightLog(context: context)
        }
    }
}
