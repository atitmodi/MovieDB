//
//  DetailScreenViewController.swift
//  MovieDB
//
//  Created by Atit Modi on 2/19/18.
//  Copyright © 2018 Atit Modi. All rights reserved.
//

import UIKit

class DetailScreenViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: CustomImageView!
    
    @IBOutlet weak var synopsis: UILabel!
    var model : MovieModel?
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        
        // Do any additional setup after loading the view.
    }
    
    func setLayout(){
        
        if let model = model{
            
            movieTitle.text = model.title
            synopsis.text = model.overview
            posterImageView.loadImageUsingUrlString((model.poster_path))
            releaseDate.text = formatDate(dateString: model.release_date)
            rating.text = "\(model.vote_average)/10(\(model.vote_count) votes)"
        }
        
    }
    
    func formatDate(dateString : String) -> String{
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterSet = DateFormatter()
        dateFormatterSet.dateFormat = "MMMM dd,yyyy"
        
        if let date: NSDate? = dateFormatterGet.date(from: dateString) as NSDate??
        {
            return dateFormatterSet.string(from: date! as Date)
        }
        
        return ""
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
