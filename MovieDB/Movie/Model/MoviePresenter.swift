//
//  MoviePresenter.swift
//  TBdm
//
//  Created by Atit Modi on 2/15/18.
//  Copyright © 2018 Atit Modi. All rights reserved.
//

import UIKit

protocol MoviePresenterDelegate {
    
    func onSuccessCallBack(model : [MovieModel])
    func onError()
}

class MoviePresenter: NSObject {
    
    var movies = [MovieModel]()
    
    let delegate : MoviePresenterDelegate?
    
    init(delgate : MoviePresenterDelegate)
    {
        self.delegate = delgate
    }
    
    
   // private let popMovieURL = URL(string: "\(Constants.BASE_URL)/discover/movie?api_key=\(Constants.API_KEY_V3)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1")
    
    func getPopularMovies(currentPage: Int = 1){
        
    let popMovieURL = URL(string: "\(Constants.BASE_URL)/discover/movie?api_key=\(Constants.API_KEY_V3)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(currentPage)")

         var session = URLSession.shared
         let config = URLSessionConfiguration.default
         session = URLSession(configuration: config)
         session.dataTask(with: popMovieURL!) { (data, response, error) in
            do{
                if(error != nil)
                {
                    //print("error is \(error)")
                    
                    CommonClass().showAlertView(errorMessage: error?.localizedDescription ?? "")
                    self.errorDelegate()
                    return
                    
                }
                if let httpResponse = response as? HTTPURLResponse {
                    
                    if(httpResponse.statusCode != 200){
                        CommonClass().showAlertView(errorMessage: "\(httpResponse.statusCode)")
                        self.errorDelegate()

                        return

                    }
                }
                if let data = data{
                
                let jsonDictionary = try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers) as? JSONDictionary
                
                if let dic = jsonDictionary
                {
                    if let moviesDict = dic["results"] as? [JSONDictionary]{
                        
                        //Binding downloaded data to model
                        self.movies = moviesDict.flatMap(MovieModel.init)
                        
                        if let delegate = self.delegate{
                            
                            //passing data to controller
                                delegate.onSuccessCallBack(model: self.movies)

                        }
                        /*self.movies.forEach({ (movies) in
                            print(movies.title)
                        })*/
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
