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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
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
    
}

extension SearchViewController : UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if(!searchText.isEmpty){
            showActivityLoader()
            searchPresenter?.getSearchApi(searchString: searchText)
        }
        
    }
}

extension SearchViewController : SearchMoviePresenterDelegate
{
    func onError() {
        
        DispatchQueue.main.async {
            self.dismissActivityLoader()
        }
        
    }
    
    func onSuccessCallBack(model: [MovieModel]) {
        
            movieModel = model
        
            DispatchQueue.main.async {
                
                self.dismissActivityLoader()
                self.searchCollectionView.reloadData()
                
            }
        
    }
    


}

