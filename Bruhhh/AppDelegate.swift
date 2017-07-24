//
//  AppDelegate.swift
//  Bruhhh
//
//  Created by Mac Demo on 1/26/16.
//  Copyright © 2016 Mac Demo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var buttonOptions: NSMutableArray?
    var buttonShortcuts: NSMutableArray?
    var userDefaults: NSMutableDictionary?
    var launchedShortcutItem: UIApplicationShortcutItem?
    let descriptionKey = "descriptionKey"
    let titleKey = "titleKey"
    let shortcutKey = "ShortcutButtons"


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        registerDefaults()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func registerDefaults() {
        
        let filePath = URL(fileURLWithPath: Bundle.main.path(forResource: "DefaultSettings", ofType: ".plist")!)
        let defaultSettings = NSDictionary(contentsOf: filePath) as! [String: AnyObject]
        UserDefaults.standard.register(defaults: defaultSettings)
    
    }
    
    func handleShortcutItem(_ shortcutItem: UIApplicationShortcutItem) {
        print("Handled shortcut item for name \(shortcutItem.type)")
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        print("The URL has been handled...")
        
        return true
    }
    
    /*
    func traitCollectionDidChange(previousTrait: UITraitCollection?) {
        print("Collection trait did change \(previousTrait)")
    }
    */

}

