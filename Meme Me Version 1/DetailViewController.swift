//
//  DetailViewController.swift
//  Meme Me Version 2
//
//  Created by Warren Hansen on 9/7/16.
//  Copyright © 2016 Warren Hansen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var meme: Meme! = nil
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    override func viewWillAppear(animated: Bool) {
        imageView.image = meme.memedImage
    }
    
    @IBAction func shareAction(sender: UIBarButtonItem) {
        let activityViewController = UIActivityViewController(activityItems: [meme.memedImage], applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true     // status bar should be hidden
    }
}