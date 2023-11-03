//
//  AppDelegate.swift
//  TestWikipedia
//
//  Created by Ruslan Kasian Dev_2 on 29.10.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        self.window =  UIWindow(frame: UIScreen.main.bounds)
        
        let initialViewController = CustomNavigationController()
        
        self.coordinator = AppCoordinator(navigationController: initialViewController)
        self.coordinator?.openVC(type: PlacesListViewController.self)
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
}
