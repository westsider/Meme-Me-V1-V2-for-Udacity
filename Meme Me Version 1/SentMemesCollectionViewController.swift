//
//  CollectionViewController.swift
//  Meme Me Version 2
//
//  Created by Warren Hansen on 9/7/16.
//  Copyright © 2016 Warren Hansen. All rights reserved.

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    // MARK: UIImage vars
    var memes = [Meme]()
    let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
  
    // MARK: Lifecycle Functions
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.memes = appDelegate.memes
        self.collectionView?.reloadData()
        self.navigationItem.title = "Sent Memes"
        self.collectionView?.backgroundColor = UIColor.whiteColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // adjustFlowLayout(view.frame.size)
        
        let space: CGFloat = 2.0
        // test push to remote 3
        // MARK: In progress - trying another way to evenly space images
        // great for verticle
       // let dimension = (self.view.frame.size.width - (2 * space)) / 3.0
        // great for horizontal
        let dimension = (self.view.frame.size.width - (5 * space)) / 5.0
        
        flowLayout.minimumLineSpacing = 2.0
        flowLayout.minimumInteritemSpacing = 2.0
        flowLayout.itemSize = CGSizeMake(dimension, dimension) //causes all cells to have the same size.
        
        // solution access height of main view
       // inset = UIEdgeInsetsMake(<#T##top: CGFloat##CGFloat#>, <#T##left: CGFloat##CGFloat#>, <#T##bottom: CGFloat##CGFloat#>, <#T##right: CGFloat##CGFloat#>)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        collectionView!.reloadData()
    }
    // MARK: Set up Collection View
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let meme = self.memes[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        cell.memeImageView.image = meme.memedImage
        cell.memeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        return cell
    }
    
     // MARK: Push details VC
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        detailViewController.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(detailViewController, animated: true)
    }
/*
    // MARK: Rezize the grid - I adapted this concept from Anna Rogers on github
    func adjustFlowLayout(size: CGSize) {
        let space: CGFloat = 2.0
        let dimension:CGFloat = size.width >= size.height ? (size.width - (5 * space)) / 6.0 :  (size.width - (2 * space)) / 3.0
        flowLayout.minimumLineSpacing = 2.0
        flowLayout.minimumInteritemSpacing = 2.0
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        adjustFlowLayout(size)
    }
*/
    override func prefersStatusBarHidden() -> Bool {
        return true     // status bar should be hidden
    }
}