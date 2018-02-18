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
    var loader = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        layoutCollectionView()
        getPopularMovies()
    }
    
    func layoutCollectionView()
    {
        movieCollectionView.register(UINib(nibName:"MovieCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
        movieCollectionView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5)
        let layout = movieCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemSizeWidth = (view.frame.size.width - 30) / 3
        let itemSizeHeight = (view.frame.size.height - 20) / 3
        layout.itemSize = CGSize(width: itemSizeWidth, height: itemSizeHeight)
        
    }
    
    func getPopularMovies()
    {
       
        showActivityLoader()
        let parser = MoviePresenter(delgate: self)
        parser.getPopularMovies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showActivityLoader()
    {
        loader.activityIndicatorViewStyle = .white
        loader.color = UIColor.white
        loader.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        loader.startAnimating()
        self.view.addSubview(loader)
    }
    
    func dismissActivityLoader()
    {
        loader.stopAnimating()
        loader.removeFromSuperview()
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        cell.model = movieModel[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieModel.count
    }
    
}

extension ViewController : MoviePresenterDelegate{
    
    func onSuccessCallBack(model: [MovieModel]) {
        
        if(!model.isEmpty){
            movieModel = model
            print(movieModel.count)
            // Update UI
            DispatchQueue.main.async {
                
                self.dismissActivityLoader()

                self.movieCollectionView.reloadData()
            }
        }
    }
    
    func onError() {
        
        DispatchQueue.main.async {
            self.dismissActivityLoader()
        }
        
    }
}
