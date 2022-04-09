//
//  AppDelegate.swift
//  LmTV-Online
//
//  Created by Юрий Чекалюк on 07.04.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //var navigationController = UINavigationController()
        //navigationController.navigationBar.prefersLargeTitles = false
        let mainViewController = MainViewController()
        //navigationController = UINavigationController(rootViewController: mainViewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainViewController
        self.window?.makeKeyAndVisible()
        //let navigationBarAppearance = UINavigationBarAppearance()
        //navigationBarAppearance.backgroundColor = #colorLiteral(red: 0.2039758265, green: 0.2036702037, blue: 0.2210701704, alpha: 1)
        //navigationBarAppearance.shadowColor = #colorLiteral(red: 0.2883119285, green: 0.2981199622, blue: 0.3153488934, alpha: 1)
        //navigationController.navigationBar.standardAppearance = navigationBarAppearance
        //navigationController.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        
        
        
        print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
        
        
        return true
    }

    



}

