//
//  AppDelegate.swift
//  ali-beyaz
//
//  Created by Ali Beyaz on 28.11.2023.
//

import UIKit
import SnapKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        configureWindow(destinationVC: LaunchesVC())

        return true
    }
    func configureWindow(destinationVC: UIViewController) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
        window?.rootViewController = destinationVC
    }


}

