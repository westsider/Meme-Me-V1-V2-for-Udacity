//
//  TableViewController.swift
//  Meme Me Version 2
//
//  Created by Warren Hansen on 9/7/16.
//  Copyright © 2016 Warren Hansen. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    
    var memes = [Meme]()
    let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.memes = appDelegate.memes
        self.tableView.reloadData()
        self.navigationItem.title = "Sent Memes"
    }
    
    // MARK: Set up tableview
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let meme = self.memes[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath) as! TableViewCell
        cell.textLabel?.text = "\(meme.topTextField) ... \(meme.bottomtextFiield)"
        cell.imageView?.image = meme.memedImage
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailViewController = self.storyboard?
            .instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        detailViewController.meme = self.memes[indexPath.row]
        detailViewController.modalTransitionStyle = .CrossDissolve
        presentViewController(detailViewController, animated: true, completion: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true     // status bar should be hidden
    }
}