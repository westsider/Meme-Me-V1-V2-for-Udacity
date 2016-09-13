//
//  SentMemesTableViewController
//  Meme Me Version 2
//
//  Created by Warren Hansen on 9/7/16.
//  Copyright © 2016 Warren Hansen. All rights reserved.

import UIKit

class SentMemesTableViewController: UITableViewController, UIViewControllerTransitioningDelegate {
    
    var memes = [Meme]()
    let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        memes = appDelegate.memes   // removed self
        tableView.reloadData()      // removed self
        navigationItem.title = "Sent Memes" // removed self
    }
    
    // MARK: Set up tableview
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count  // removed self
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let meme = self.memes[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath) as! TableViewCell
        cell.cellLabel.text = "\(meme.topTextField) ... \(meme.bottomtextFiield)"
        cell.memeImageView.image = meme.memedImage

        return cell
    }
    
    // MARK: Added functionality - swipe left removes item
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            appDelegate.memes.removeAtIndex(indexPath.row)  // added as per instructor
            memes.removeAtIndex(indexPath.row)
            tableView.reloadData()  // removed self
        }
    }
    
    // MARK: Push details VC
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        detailViewController.meme = self.memes[indexPath.row]
        navigationController!.pushViewController(detailViewController, animated: true)  // removed self
    }

    override func prefersStatusBarHidden() -> Bool {
        return true     // status bar should be hidden
    }
}