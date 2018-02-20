//
//  Extensions.swift
//  TBdm
//
//  Created by Atit Modi on 2/18/18.
//  Copyright © 2018 Atit Modi. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    var loader = UIActivityIndicatorView()

    func loadImageUsingUrlString(_ urlString: String) {
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        if let url = url{
            //showActivityLoader()
        URLSession.shared.dataTask(with: url, completionHandler: { (data, respones, error) in
            
            if error != nil {
               // self.dismissActivityLoader()
                return
            }
            
            DispatchQueue.main.async(execute: {
                
               // self.dismissActivityLoader()
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
            })
            
        }).resume()
        }
    }
    
    
    func showActivityLoader()
    {
        loader.activityIndicatorViewStyle = .white
        loader.color = UIColor.white
        loader.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        loader.startAnimating()
        self.addSubview(loader)
    }
    
    func dismissActivityLoader()
    {
        loader.stopAnimating()
        loader.removeFromSuperview()
    }

}

