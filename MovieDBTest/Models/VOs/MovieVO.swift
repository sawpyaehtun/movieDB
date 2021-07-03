//
//  MovieVO.swift
//  MovieDBTest
//
//  Created by Tamron iMac 001 on 7/3/21.
//

import Foundation
import RealmSwift

struct MovieVO : Codable, Hashable{
    let id : Int?
    let posterPath : String?
    let overview : String?
    let title : String?
}

extension MovieVO {
    
    func toUpcomingMovieRO() -> UpComingMovieRO{
        
        return UpComingMovieRO(id: id, posterPath: posterPath, overview: overview, title: title)
    }
    
    func toPopularMovieRO() -> PopularMovieRO{
        return PopularMovieRO(id: id, posterPath: posterPath, overview: overview, title: title)
    }
    
    func toFavouriteMovieRO() -> FavouriteMovieRO {
        return FavouriteMovieRO(id: id, posterPath: posterPath, overview: overview, title: title)
    }
    
}
