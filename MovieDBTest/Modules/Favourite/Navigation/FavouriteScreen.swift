//
//  FavouriteScreen.swift
//  MovieDBTest
//
//  Created by MyMacBookPro on 04/07/2021.
//

import Foundation

struct FavouriteScreen {
    
    enum FavouriteVC {
        case navigateToMovieDetail( _ movie : MovieVO)
        
        func show() {
            switch self {
            case .navigateToMovieDetail(let movie):
                AppScreens.shared.navigateToMovieDetail(movie: movie)
            }
        }
    }
}
