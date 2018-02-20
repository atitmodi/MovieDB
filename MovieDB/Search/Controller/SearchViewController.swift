//
//  SearchViewController.swift
//  MovieDB
//
//  Created by Atit Modi on 2/17/18.
//  Copyright © 2018 Atit Modi. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var loader = UIActivityIndicatorView()
    
    // array to hold the model data
    var movieModel = [MovieModel]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    var searchPresenter : SearchMoviePresenter?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        layoutCollectionView()
        searchPresenter = SearchMoviePresenter(delgate: self)
    }
    
    func layoutCollectionView(){
        
        searchCollectionView.register(UINib(nibName:"MovieCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
        
        searchCollectionView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5)
        
        //setting collection view layout according to size of the screen
        let layout = searchCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemSizeWidth = (view.frame.size.width - 30) / 3
        let itemSizeHeight = (view.frame.size.height - 20) / 3
        layout.itemSize = CGSize(width: itemSizeWidth, height: itemSizeHeight)
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
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        searchBar.resignFirstResponder()
        searchBar.text = ""
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "DetailScreen" {
            
            if let dest = segue.destination as? DetailScreenViewController,
                let index = sender as? IndexPath{
                dest.model = movieModel[index.row]
            }
            
        }
        
    }
    
    
}

// MARK:- UICollectionView  Delegate and DataSource

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        cell.model = movieModel[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "DetailScreen", sender: indexPath)
    }
    
}

// MARK:- UISearchBarDelegate  Delegate

extension SearchViewController : UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if(!searchText.isEmpty){
            showActivityLoader()
            searchPresenter?.getSearchApi(searchString: searchText)
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK:-  Parser Delegate

extension SearchViewController : SearchMoviePresenterDelegate
{
    func onError() {
        
        //updating UI in mai thread
        
        DispatchQueue.main.async {
            self.dismissActivityLoader()
        }
        
    }
    
    func onSuccessCallBack(model: [MovieModel]) {
        
        movieModel = model
        
        //updating UI in mai thread
        DispatchQueue.main.async {
            
            self.dismissActivityLoader()
            self.searchCollectionView.reloadData()
            
        }
        
    }
    
    
    
}

