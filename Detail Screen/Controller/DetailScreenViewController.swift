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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("viewDidLoad")
        print(model?.title)
        synopsis.text = model?.overview ?? ""
        posterImageView.loadImageUsingUrlString((model?.poster_path)!)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
