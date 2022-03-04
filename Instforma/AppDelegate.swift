//
//  AppDelegate.swift
//  Instforma
//
//  Created by Ivan Ceaicovschi on 22/01/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
<<<<<<< HEAD
=======
    
    var dependencyModule: IAppStorageDependencyModule = ProdAppStorageDependencyModule()

>>>>>>> master

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
<<<<<<< HEAD
        window.rootViewController = UINavigationController(rootViewController: HomeViewController())
=======
        window.rootViewController = UINavigationController(rootViewController: MainViewController())
>>>>>>> master
        window.makeKeyAndVisible()
        self.window = window
        return true
    }

}

