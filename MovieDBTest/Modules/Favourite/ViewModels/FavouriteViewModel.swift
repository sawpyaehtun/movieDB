//
//  FavouriteViewModel.swift
//  MovieDBTest
//
//  Created by Tamron iMac 001 on 7/3/21.
//

import RxSwift
import RxCocoa

class FavouriteViewModel: BaseViewModel {
    
    let movieListPublishRelay = PublishRelay<[MovieVO]>()
    let provider = MovieProvider()
    
}

extension FavouriteViewModel {
    
    func getFavouritMovieListFromDB(){
        movieListPublishRelay.accept(provider.getMovieList(type: .FavouriteMovieRO))
    }
    
}
