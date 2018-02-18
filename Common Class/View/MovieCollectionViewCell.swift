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
    
    var model : MovieModel?{
        didSet{
            do{
                //imageView.image = try UIImage.init(data: .init(contentsOf: URL(string: (model?.poster_path)!)!))
                if let poster_path = model?.poster_path{
                    imageView.loadImageUsingUrlString(poster_path)
                }
                titleLabel.text = model?.title
            }
            catch{
                print(error)
            }
        }
    }
    
    
}
