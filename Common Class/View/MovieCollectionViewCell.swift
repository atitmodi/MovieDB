//
//  MovieCollectionViewCell.swift
//  TBdm
//
//  Created by Atit Modi on 2/17/18.
//  Copyright © 2018 Atit Modi. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: CustomImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //setting data for collection view
    var model : MovieModel?{
        didSet{
            
            if let poster_path = model?.poster_path{
                
                //subclassing imageview to download image and adding to cache
                //we can use SDWebImage library
                imageView.loadImageUsingUrlString(poster_path)
            }
            titleLabel.text = model?.title
        }
        
    }
}
    
