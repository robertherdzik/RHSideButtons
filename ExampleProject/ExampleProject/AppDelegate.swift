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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let windowFrame = UIScreen.main.bounds
        window = UIWindow(frame: windowFrame)
        
        navigationController = getPreparedNavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
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

