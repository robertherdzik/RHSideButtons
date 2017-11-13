//
//  AppDelegate.swift
//  ExampleProject
//
//  Created by Robert Herdzik on 04/04/2017.
//  Copyright © 2017 Robert Herdzik. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var navigationController: UINavigationController!
    
    var operationQueue = OperationQueue()
    var operationQueue2 = OperationQueue()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let windowFrame = UIScreen.main.bounds
        window = UIWindow(frame: windowFrame)
        
        navigationController = getPreparedNavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        operationQueue.maxConcurrentOperationCount = 1
        operationQueue2.maxConcurrentOperationCount = 1
        
        let operation = BlockOperation { 
            sleep(8)
            print("❤️ operation")
            
        }
        
        let operation2 = BlockOperation {
//            sleep(1)
            print("❤️ operation2")
        }
        
        let operation1 = BlockOperation {
            sleep(1)
            print("❤️ operation1")
            
            
        }
        
        let operation3 = BlockOperation {
            sleep(6)
            print("❤️ operation3")
            
            operation2.addDependency(operation)
        }
        
        operation1.addDependency(operation2)
        
//        operation1.addDependency(operation)
        
        
        
//        operation2.addDependency(operation)
        
        operationQueue.addOperations([operation, operation1], waitUntilFinished: false)
        operationQueue2.addOperations([operation3, operation2], waitUntilFinished: false)
//        operationQueue2.addOperation(operation2)
        
        
        return true
    }
    
    fileprivate func getPreparedNavigationController() -> UINavigationController {
        let mainViewController = MainViewController()
        
        // I would like to show you how this control looks like, so simple demo presenter class was needed
        let demoPresenter = ButtonsDemoPresenter(mainViewController: mainViewController)
        mainViewController.demoPresenter = demoPresenter
        
        return UINavigationController(rootViewController: mainViewController)
    }
}

