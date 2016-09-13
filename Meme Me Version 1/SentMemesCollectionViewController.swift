//
//  SentMemesCollectionViewController
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
        memes = appDelegate.memes       // removed self
        collectionView?.reloadData()    // removed self
        navigationItem.title = "Sent Memes"     // removed self
        collectionView?.backgroundColor = UIColor.whiteColor()      // removed self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutCells()
    }
    
    // MARK: Layout cell spacing. I looked at some of the techniques from Mike Miller  https://github.com/mikemdev40/MemeMe-V2.0
    struct Constants {
        static let CellVerticalSpacing: CGFloat = 2
    }
    
    ///this method determines the cell layout (and does do differently depending on whether the device is in portrait or landscape mode) and is called when "viewDidLayoutSubviews" is called (which happens multiple times throughout the view controller's lifecycle, as well as when the device is phycially rotated)
    func layoutCells() {
        var cellWidth: CGFloat
        var numWide: CGFloat
        
        //sets the number of cells to display horizontally in each row based on the device's orientation
        switch UIDevice.currentDevice().orientation {
        case .Portrait:
            numWide = 3
        case .PortraitUpsideDown:
            numWide = 3
        case .LandscapeLeft:
            numWide = 4
        case .LandscapeRight:
            numWide = 4
        default:
            numWide = 4
        }
        //sets the cell width to be dependent upon the number of cells that will be displayed in each row, as determined directly above
        cellWidth = collectionView!.frame.width / numWide
        
        //updates the cell width to account for the desired cell spacing (a predetermined constant, defined in the Constants struct), then updates the itemSize accordingly
        cellWidth -= Constants.CellVerticalSpacing
        flowLayout.itemSize.width = cellWidth
        flowLayout.itemSize.height = cellWidth
        flowLayout.minimumInteritemSpacing = Constants.CellVerticalSpacing
        
        //calculates the actual vertical spacing between cells, accounting for the additional vertical space that was subtracted from the cell width (e.g. if there are 3 cells, there are only 2 vertical spaces, not 3); then by setting the line spacing to be equal to this "actual" value, the vertical and horizontal distances between cells should be exact (or as close to exact as possible)
        let actualCellVerticalSpacing: CGFloat = (collectionView!.frame.width - (numWide * cellWidth))/(numWide - 1)
        flowLayout.minimumLineSpacing = actualCellVerticalSpacing
        
        //causes the collection view to invalidate its current layout and relay out the collection view using the new settings in the flow layout (without this call, the cells don't properly resize upon rotation)
        flowLayout.invalidateLayout()
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
    
    override func prefersStatusBarHidden() -> Bool {
        return true     // status bar should be hidden
    }
}