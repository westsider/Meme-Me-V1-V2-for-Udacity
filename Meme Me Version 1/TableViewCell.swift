//
//  SentMemesUICollectionViewCell.swift
//  Meme Me Version 1
//
//  Created by Warren Hansen on 9/7/16.
//  Copyright © 2016 Warren Hansen. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var cellLabel: UILabel!
    
    @IBOutlet weak var memeImageView: UIImageView!
    
   
    
    //@IBOutlet weak var memeImage: UIImageView!
    //@IBOutlet weak var titleLabel: UILabel!
    
    /*
    memeImageView.translatesAutoresizingMaskIntoConstraints = false
    let widthContsraint = NSLayoutConstraint(item: memeImageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 100)
    let heightConstraint = NSLayoutConstraint(item: memeImageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 100 )
    memeImageView.addConstraints([widthContsraint, heightConstraint])
 */
}