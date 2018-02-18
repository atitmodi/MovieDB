//
//  MovieModel.swift
//  TBdm
//
//  Created by Atit Modi on 2/15/18.
//  Copyright © 2018 Atit Modi. All rights reserved.
//

import UIKit


class MovieModel: NSObject {
    
    
        var vote_count = 0
        var id = 0
        var video = false
        var vote_average = 0
        var title = ""
        var popularity = 0.00
        var poster_path = ""
        var original_language = ""
        var original_title = ""
        var genre_ids = [Int]()
        var backdrop_path = ""
        var adult = false
        var overview = ""
        var release_date = ""
        
        init(dic : JSONDictionary) {
            
            vote_count = dic["vote_count"] as? Int ?? 0
            id = dic["id"] as? Int ?? 0
            poster_path = dic["poster_path"] as? String ?? ""
            if(poster_path != ""){
               poster_path = "https://image.tmdb.org/t/p/w500/\(poster_path)"
            }
            else{
                //poster_path = "http://laughshop.com/wp-content/uploads/2017/04/Hi-To-All-My-peeps.jpg"
            }
            title = dic["title"] as? String ?? ""
            original_title = dic["original_title"] as? String ?? ""
            popularity = dic["popularity"] as? Double ?? 0.0
            vote_average = dic["vote_average"] as? Int ?? 0
            overview = dic["overview"] as? String ?? ""
            backdrop_path = dic["backdrop_path"] as? String ?? ""
            
        }
    
}

