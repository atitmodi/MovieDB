//
//  SearchMoviePresenter.swift
//  TBdm
//
//  Created by Atit Modi on 2/18/18.
//  Copyright © 2018 Atit Modi. All rights reserved.
//

import UIKit

protocol SearchMoviePresenterDelegate {
    
    func onSuccessCallBack(model : [MovieModel])
    func onError()
}

class SearchMoviePresenter: NSObject {

    var session = URLSession.shared

    
    let delegate : SearchMoviePresenterDelegate?
    
    init(delgate : SearchMoviePresenterDelegate)
    {
        self.delegate = delgate
    }
    
    
    var movies = [MovieModel]()

    func getSearchApi(searchString : String){

    let searchUrl = URL(string: "\(Constants.BASE_URL)/search/movie?api_key=\(Constants.API_KEY_V3)&language=en-US&query=\(searchString)&include_adult=false")

        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
        
        // downloading data
        session.dataTask(with: searchUrl!) { (data, response, error) in
            do{
                if(error != nil)
                {
                    //print("error is \(error)")
                    DispatchQueue.main.async {
                        CommonClass().showAlertView(errorMessage: error?.localizedDescription ?? "")
                        self.errorDelegate()
                        return

                    }
                    
                }
                if let httpResponse = response as? HTTPURLResponse {
                    
                    if(httpResponse.statusCode != 200){
                        
                        DispatchQueue.main.async {

                        CommonClass().showAlertView(errorMessage: "\(httpResponse.statusCode)")
                        self.errorDelegate()
                        
                        return
                        }
                    }
                }
                if let data = data{
                    
                    let jsonDictionary = try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers) as? JSONDictionary
                    
                    if let dic = jsonDictionary
                    {
                        if let moviesDict = dic["results"] as? [JSONDictionary]{
                            self.movies = moviesDict.flatMap(MovieModel.init)
                            
                            if let delegate = self.delegate{
                                
                                // getting main queue to pass the data and update UI
                                DispatchQueue.main.async {
                                    //passing data to controller
                                    delegate.onSuccessCallBack(model: self.movies)

                                }
                            
                            }
                        }
                    }
                }
            }
            catch{
                print(error)
            }
            }.resume()
    }
    
    func errorDelegate()
    {
        if let delegate = self.delegate{
            
            delegate.onError()
        }
    }

}
