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
        // loading memes to fast make sure UI checks out
        loadMemes() // removed self
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }
    
    func loadMemes() {
        let memes = [
            Meme(topTextField: "U D A C I T Y", bottomtextFiield: "R O C K S", originalImage: UIImage(named: "placeholder")!, memedImage: UIImage(named: "1")!),
            Meme(topTextField: "WHEN YOURE AT WORK", bottomtextFiield: "TRYNG TO STAY POSATIVE", originalImage: UIImage(named: "placeholder")!, memedImage: UIImage(named: "2")!),
            Meme(topTextField: "YOURE A FUNNY GUY", bottomtextFiield: "I LIKE THAT", originalImage: UIImage(named: "placeholder")!, memedImage: UIImage(named: "3")!),
            Meme(topTextField: "WHAT IF 666", bottomtextFiield: "IS THE SQUARE ROOT", originalImage: UIImage(named: "placeholder")!, memedImage: UIImage(named: "4")!),
            Meme(topTextField: "BE THERE", bottomtextFiield: "OR BE SQUARE", originalImage: UIImage(named: "placeholder")!, memedImage: UIImage(named: "5")!),
            Meme(topTextField: "NEED AN ARC?", bottomtextFiield: "I NOAH GUY", originalImage: UIImage(named: "placeholder")!, memedImage: UIImage(named: "6")!)
        ]
        
        for meme in memes {
            self.memes.append(meme)
            print(meme)
        }
        
    }
     

}

