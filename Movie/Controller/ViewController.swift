//
//  ViewController.swift
//  MovieDB
//
//  Created by Atit Modi on 2/17/18.
//  Copyright © 2018 Atit Modi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var movieCollectionView: UICollectionView!
    var movieModel = [MovieModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     
        let parser = MoviePresenter(delgate: self)
        parser.getPopularMovies()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : MoviePresenterDelegate{
    
    func onSuccessCallBack(model: [MovieModel]) {
        
        if(!model.isEmpty){
            
            movieModel = model
            print(movieModel.count)
            // Update UI
       
        }
    }
    
}
