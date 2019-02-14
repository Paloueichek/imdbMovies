//
//  AppDelegate.swift
//  imdbMovies
//
//  Created by Patrick Aloueichek on 2/11/19.
//  Copyright © 2019 Patrick Aloueichek. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var naviApp: UINavigationController?
    var homeVC: MoviesTableViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        homeVC = MoviesTableViewController(nibName: "MoviesTableViewController", bundle: nil)
        naviApp = UINavigationController(rootViewController: homeVC!)
        homeVC?.networkManager = NetworkManagerImpl()
        window?.rootViewController = naviApp
        window?.makeKeyAndVisible()
        
        return true
    }
}

