//
//  AppDelegate.swift
//  Meme Me Version 2
//
//  Created by Warren Hansen on 8/27/16.
//  Copyright © 2016 Warren Hansen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
 
    var window: UIWindow?
    var memes = [Meme]()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // loading severAL memes to QUICKLY make sure UI checks out OK
        self.loadMemes()
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
    
    func loadMemes() {
        let memes = [
            Meme(topTextField: "I DONT ALWAYS SAY SOMETHING STUPID,", bottomtextFiield: "BUT WHEN I DO, I KEEP TALKING TO MAKE IT WORSE", originalImage: UIImage(named: "placeholder")!, memedImage: UIImage(named: "1")!),
            Meme(topTextField: "I DONT NORMALLY SURF THE INTERNET", bottomtextFiield: "BUT WHEN I DO, I JUST BROWSE", originalImage: UIImage(named: "placeholder")!, memedImage: UIImage(named: "2")!),
            Meme(topTextField: "THINK POSATIVE", bottomtextFiield: "FOREXAMPLE I FELL OFF A LADDER", originalImage: UIImage(named: "placeholder")!, memedImage: UIImage(named: "3")!),
            Meme(topTextField: "95% OF ALL HARLEYS ARE STILL ON THE ROAD", bottomtextFiield: "THE OTHER 5% BROKE DOWN IN THE DRIVEWAY", originalImage: UIImage(named: "placeholder")!, memedImage: UIImage(named: "4")!),
            Meme(topTextField: "THIS ISNT EVEN", bottomtextFiield: "REMOTELY FUNNY", originalImage: UIImage(named: "placeholder")!, memedImage: UIImage(named: "5")!),
            Meme(topTextField: "BRACE YOURSELF", bottomtextFiield: "WINTER IS COMMING", originalImage: UIImage(named: "placeholder")!, memedImage: UIImage(named: "6")!),
            Meme(topTextField: "HOLD UP", bottomtextFiield: "I GOTA INSTAGRAM THIS", originalImage: UIImage(named: "placeholder")!, memedImage: UIImage(named: "7")!),
            Meme(topTextField: "OH YEAH, LOVING THIS", bottomtextFiield: "NEVER BEEN HAPPIER", originalImage: UIImage(named: "placeholder")!, memedImage: UIImage(named: "8")!),
            Meme(topTextField: "MAYBE I ATE ALL THE MARSHMELLOWS", bottomtextFiield: "AND MAYBE I DIDN'T", originalImage: UIImage(named: "placeholder")!, memedImage: UIImage(named: "9")!)
        ]
        
        for meme in memes {
            self.memes.append(meme)
            print(meme)
        }
        
    }
     

}

