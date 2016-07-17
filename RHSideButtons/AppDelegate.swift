//
//  AppDelegate.swift
//  RHSideButtons
//
//  Created by Robert Herdzik on 20/05/16.
//  Copyright © 2016 Robert Herdzik. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        navigationController = getPreparedNavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

    private func getPreparedNavigationController() -> UINavigationController {
        let mainViewController = MainViewController(nibName: nil, bundle: nil)
        
        // I would like to show you how this control looks like, so simple demo presenter class was needed
        let demoPresenter = ButtonsDemoPresenter(mainViewController: mainViewController)
        mainViewController.demoPresenter = demoPresenter
        
        return UINavigationController(rootViewController: mainViewController)
    }
}

