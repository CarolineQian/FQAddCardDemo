//
//  AppDelegate.swift
//  addCardDemo
//
//  Created by 冯倩 on 2017/6/30.
//  Copyright © 2017年 冯倩. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        let rootVC = ViewController()
        let nav = UINavigationController(rootViewController: rootVC)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        return true
    }

}

