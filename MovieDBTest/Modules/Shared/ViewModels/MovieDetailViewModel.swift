//
//  MovieDetailViewModel.swift
//  MovieDBTest
//
//  Created by MyMacBookPro on 04/07/2021.
//

import Foundation
import RxCocoa
import RxSwift

class MovieDetailViewModel: BaseViewModel {
    
    let provider = MovieProvider()
    let favMovieListPublishRelay = PublishRelay<[MovieVO]>()
    
    func addToFavourite(movie : MovieVO){
        provider.setMovie(movie: movie, type: .FavouriteMovieRO)
    }
    
    func removeFromFavourite(moview : MovieVO){
        provider.removeMovie(movie: moview, type: .FavouriteMovieRO)
    }
    
    func getFavMovieList(){
        let movieList = provider.getMovieList(type: .FavouriteMovieRO)
        favMovieListPublishRelay.accept(movieList)
    }
}
