//
//  AppDelegate.swift
//  calendar
//
//  Created by M A on 11/05/2020.
//  Copyright © 2020 M A. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
//    var window: UIWindow?
    
    // 選択された日 キャプション表示に使う
    var selectedDay = Date()
    // 表示月の初日 タイトルラベルに使う
    var firstDay = Date()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        self.window?.rootViewController = ViewController()
//        self.window?.makeKeyAndVisible()
        // ナビゲーションバーの色指定
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.5, green: 0.8090446002, blue: 0.9884150257, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

