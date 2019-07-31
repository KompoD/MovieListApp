//
//  AppDelegate.swift
//  MoviesListApp
//
//  Created by Nikita Merkel on 19/07/2019.
//  Copyright © 2019 Nikita Merkel. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // DI provider
        let networkManager = NetworkManager.shared
        
        // Setup start screen and injection
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navVC = storyboard.instantiateViewController(withIdentifier: "movieNavVC") as! UINavigationController
        let movieListVC = navVC.visibleViewController as! MovieListController
        movieListVC.networkManager = networkManager
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        
        return true
    }
}
