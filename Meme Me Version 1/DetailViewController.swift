//
//  DetailViewController.swift
//  Meme Me Version 2
//
//  Created by Warren Hansen on 9/7/16.
//  Copyright © 2016 Warren Hansen. All rights reserved.

import UIKit

class DetailViewController: UIViewController {
    
    var meme: Meme! = nil
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)  // added per instructor
        imageView.image = meme.memedImage
    }
    
    @IBAction func cancelAction(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)    // removed self
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true     // status bar should be hidden
    }
}