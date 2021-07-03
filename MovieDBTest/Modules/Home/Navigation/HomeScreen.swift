//
//  HomeScreen.swift
//  MovieDBTest
//
//  Created by MyMacBookPro on 04/07/2021.
//

import Foundation

struct HomeScreen {
    
    enum HomeVC {
        case navigateToMovieDetail( _ movie : MovieVO)
        
        func show() {
            switch self {
            case .navigateToMovieDetail(let movie):
                AppScreens.shared.navigateToMovieDetail(movie: movie)
            }
        }
    }
}
