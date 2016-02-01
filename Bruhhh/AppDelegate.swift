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
    let descriptionKey = "descriptionKey"
    let titleKey = "titleKey"


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //createButtonOptions()
        
        //NSUserDefaults.standardUserDefaults().registerDefaults(<#T##registrationDictionary: [String : AnyObject]##[String : AnyObject]#>)
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func createButtonOptions() {
        let archerFail = [titleKey: "Archer Fail", descriptionKey: "archer-fail"]
        let cutHim = [titleKey: "Girl, I Cut Him", descriptionKey: "bon-qui-girl-i-cut-him"]
        let rude = [titleKey: "Rude", descriptionKey: "bon-qui-rude"]
        let security = [titleKey: "Security", descriptionKey: "bon-qui-security"]
        let bruh = [titleKey: "Bruh", descriptionKey: "bruh-sound-effect"]
        let byeFelicia = [titleKey: "Bye Felicia", descriptionKey: "bye-felicia"]
        let hummina = [titleKey: "Hummina", descriptionKey: "dave-chappelle-hummina"]
        let deezNuts = [titleKey: "Deez Nuts", descriptionKey: "deez-nuts"]
        let gotHim = [titleKey: "Got Em", descriptionKey: "got-him"]
        let gotchaBitch = [titleKey: "Gotcha Bitch", descriptionKey: "gotcha-bitch"]
        let hahGay = [titleKey: "Ha Gay", descriptionKey: "hah-gay"]
        let shazam = [titleKey: "Shazam", descriptionKey: "shazam"]
        let thatsEasy = [titleKey: "That Was Easy", descriptionKey: "that-was-easy"]
        let sheSaid = [titleKey: "That's What She Said", descriptionKey: "thats-what-she-said"]
        let wrapItUp = [titleKey: "Wrap It Up", descriptionKey: "wrap-it-up-music"]
        
        buttonOptions?.addObjectsFromArray([archerFail, cutHim, rude, security, bruh, byeFelicia, hummina, deezNuts, gotHim, gotchaBitch, hahGay, shazam, thatsEasy, sheSaid, wrapItUp])
        
        
    
    }
    
    func createShortcutItems() {
        
    }
    
    


}

