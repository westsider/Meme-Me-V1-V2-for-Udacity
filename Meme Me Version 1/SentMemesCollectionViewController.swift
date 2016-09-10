//
//  CollectionViewController.swift
//  Meme Me Version 2
//
//  Created by Warren Hansen on 9/7/16.
//  Copyright © 2016 Warren Hansen. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    var memes = [Meme]()
    let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let spaceM = CGFloat(3.0)
        let widthM = Double(self.view.frame.size.width)
        let dimensionM = CGFloat((widthM - (2 * Double(spaceM))) / 3.0)
        flowLayout.minimumLineSpacing = spaceM
        flowLayout.minimumInteritemSpacing = spaceM
        flowLayout.itemSize = CGSizeMake(dimensionM, dimensionM)
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.memes = appDelegate.memes
        self.collectionView?.reloadData()
        self.navigationItem.title = "Sent Memes"
        self.collectionView?.backgroundColor = UIColor.whiteColor()
    }
    
    // MARK: Set up Collection
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let meme = self.memes[indexPath.row]
        let cell = self.collectionView!.dequeueReusableCellWithReuseIdentifier("CustomMemeCell", forIndexPath: indexPath)
        cell.backgroundView = UIImageView(image: meme.memedImage)
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
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