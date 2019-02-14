//
//  AppDelegate.swift
//  MakerMate
//
//  Created by Jens Van Steen on 29/01/2019.
//  Copyright © 2019 Jens Van Steen. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import FirebaseFirestore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //        changeAppereanceBackButton()
        
        //setup IQKeyBoardManager - Will push view up to show textfield above keyboard in app
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        
        //setup Firebase
        FirebaseApp.configure()
        
//        let db = Firestore.firestore()
//
//        let storage = Storage.storage()
//
//        print(db)

        let onBoardingDone = UserDefaults.standard.bool(forKey: "boardingDone")
        
        if onBoardingDone {
            launchStoryboard(storyboard: "Main")
        } else {
            launchStoryboard(storyboard: "Onboarding")
        }

        launchStoryboard(storyboard: "Onboarding")
        
        
        if let lastproject = UserDefaults.standard.string(forKey: "lastProject") {
            LastProject.shared.idLastProject = lastproject
        }
        
        
//        let user = Auth.auth().currentUser!
//
//        // 4
//        do {
//            try Auth.auth().signOut()
//        } catch (let error) {
//            print("Auth sign out failed: \(error)")
//        }
        
        return true
    }
    
    func launchStoryboard(storyboard: String) {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let controller = storyboard.instantiateInitialViewController()
        self.window?.rootViewController = controller
    }
    
 
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
//        let user = Auth.auth().currentUser
        
        // 4
        do {
            try Auth.auth().signOut()
        } catch (let error) {
            print("Auth sign out failed: \(error)")
        }
        
        
    }
    
}

