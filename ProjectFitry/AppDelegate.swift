//
//  AppDelegate.swift
//  ProjectFitry
//
//  Created by Faannaka on 26.04.17.
//  Copyright © 2017 Anar Baghirov. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        openLoginScreenIfNeeded()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataStack.shared.saveContext()
    }
    
    func openLoginScreenIfNeeded() {
        let customersCount = CoreDataStack.shared.count(of: Customer.self)
        
        if customersCount == 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginController = storyboard.instantiateViewController(withIdentifier: "loginController")
            
            window?.rootViewController = loginController
            window?.makeKeyAndVisible()
        }
    }

}

