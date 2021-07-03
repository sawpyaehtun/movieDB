//
//  MovieRO.swift
//  MovieDBTest
//
//  Created by Tamron iMac 001 on 7/3/21.
//

import RealmSwift

@objcMembers class MovieRO : Object{
    dynamic var id : Int = 0
    dynamic var posterPath : String?
    dynamic var overview : String?
    dynamic var title : String?
    
    convenience init(id : Int?, posterPath : String?, overview : String?, title : String?) {
        self.init()
        self.id = id ?? 0
        self.posterPath = posterPath
        self.overview = overview
        self.title = title
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func toMovieVO() -> MovieVO {
        
        return MovieVO(id: self.id,
                       posterPath: self.posterPath,
                       overview: self.overview,
                       title: self.title)
        
    }
}

class PopularMovieRO: MovieRO {
    
}

class UpComingMovieRO: MovieRO {

}

class FavouriteMovieRO: MovieRO {
    
}
