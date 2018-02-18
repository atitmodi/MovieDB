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
    
    @IBOutlet weak var filterBarButton: UIBarButtonItem!
    
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


    @IBAction func filterButtonPressed(_ sender: Any) {
        
        presentActionSheet()
        
    }
    
    // MARK:- Action Sheet For Filter
    func presentActionSheet(){
        
        let optionMenu = UIAlertController(title: nil, message: "Sort By", preferredStyle: .actionSheet)
        optionMenu.view.backgroundColor = UIColor.black
        optionMenu.view.tintColor   = UIColor.black
        
        let popularityAction = UIAlertAction(title: "Popularity", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.sortByPopularity()
        })
        let ratingsAction = UIAlertAction(title: "Highest Rated", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.sortByHighestRate()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        
        optionMenu.addAction(popularityAction)
        optionMenu.addAction(ratingsAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    // MARK:- Sorting Functions
    func sortByPopularity(){
        movieModel.sort { (movie1, movie2) -> Bool in
            movie1.popularity > movie2.popularity
        }
        movieCollectionView.reloadData()
    }
    
    func sortByHighestRate(){
        movieModel.sort { (movie1, movie2) -> Bool in
            movie1.vote_average > movie2.vote_average
        }
        movieCollectionView.reloadData()
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
