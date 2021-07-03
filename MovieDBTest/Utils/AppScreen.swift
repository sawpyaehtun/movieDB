//
//  AppScreen.swift
//  MovieDBTest
//
//  Created by Tamron iMac 001 on 7/3/21.
//

import UIKit

struct AppScreens {
    
    static var shared = AppScreens()
    var currentVC : UIViewController?
    
    
    func navigateToBack(animated : Bool = true){
        currentVC?.navigationController?.popViewController(animated: animated)
    }
    
    func navigateToMovieDetail(movie : MovieVO){
        let vc = MovieDetailViewController.init()
        vc.movie = movie
        currentVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
