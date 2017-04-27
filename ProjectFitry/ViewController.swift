//
//  ViewController.swift
//  ProjectFitry
//
//  Created by Faannaka on 26.04.17.
//  Copyright © 2017 Anar Baghirov. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    lazy var fetchedResultController: NSFetchedResultsController<Customer> = {
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        let controller = CoreDataStack.shared.fetchedResultController(Customer.self, sort: [sortDescriptor])
        
        return controller
    }()
    
    lazy var customers: [Customer] = {
        return CoreDataStack.shared.fetchedObjects(controller: self.fetchedResultController)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let a = CoreDataStack.shared.create(Customer.self)
        print(a.name ?? "Anar")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

