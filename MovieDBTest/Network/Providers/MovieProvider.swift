//
//  MovieProvider.swift
//  MovieDBTest
//
//  Created by Tamron iMac 001 on 7/3/21.
//

import Foundation
import RxCocoa
import RxSwift

class MovieProvider {
    
    enum FetchMovieType {
        case popular
        case upcoming
    }
    
    func fetchMovieDetail(movieId : Int) -> Observable<MovieVO?> {
        
        let url = ApiConfig.Movie.detail(movieId).getUrl()
        
        return ApiClient.shared.request(url: url).flatMap{ data -> Observable<MovieVO?> in
            if let movie = data.decode(modelType: MovieVO.self){
                return Observable.just(movie)
            }
            
            return Observable.just(nil)
        }
    }
    
    func fetchMovie(pageId : Int = 1, fetchMovieType : FetchMovieType) -> Observable<[MovieVO]> {
        var url = ""
        
        switch fetchMovieType {
        case .upcoming:
            url = ApiConfig.Movie.upcoming.getUrl()
        case .popular:
            url = ApiConfig.Movie.popular.getUrl()
        }
        
        let params = ApiRequest.Movie.getMovieList(pageId).getParams()
        
        return ApiClient.shared.request(url: url,parameters: params).flatMap{ data -> Observable<[MovieVO]> in
            if let movieList = data.filterByKey(keys: .results).decode(modelType: [MovieVO].self){
                return Observable.just(movieList)
            }
            
            return Observable.just([])
        }
    }
        
}

//MARK:- database
extension MovieProvider {
    
    func getMovieList(type : ROname) -> [MovieVO]{
        if let movieList = DBManager.sharedInstance.getDataFromDB(roName: type) as? [MovieRO]{
            return movieList.map{$0.toMovieVO()}
        }
        return []
    }
    
    func setMovieList(movieList : [MovieVO], type : ROname){
        switch type {
        case .PopularMovieRO:
            let movieROList = movieList.map{$0.toPopularMovieRO()}
            DBManager.sharedInstance.addData(objectArray: movieROList)
        case .UpComingMovieRO:
            let movieROList = movieList.map{$0.toUpcomingMovieRO()}
            DBManager.sharedInstance.addData(objectArray: movieROList)
        case .FavouriteMovieRO:
            let movieROList = movieList.map{$0.toFavouriteMovieRO()}
            DBManager.sharedInstance.addData(objectArray: movieROList)
        }
    }
    
    func setMovie(movie : MovieVO, type : ROname){
        switch type {
        case .PopularMovieRO:
            DBManager.sharedInstance.addData(object: movie.toPopularMovieRO())
        case .UpComingMovieRO:
            DBManager.sharedInstance.addData(object: movie.toUpcomingMovieRO())
        case .FavouriteMovieRO:
            DBManager.sharedInstance.addData(object: movie.toFavouriteMovieRO())
        }
    }
    
    func removeMovie(movie : MovieVO, type : ROname){
        DBManager.sharedInstance.deleteData(id: movie.id ?? 0, roName: type)
    }
    
}
