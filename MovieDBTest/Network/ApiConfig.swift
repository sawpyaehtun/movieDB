//
//  ApiConfig.swift
//  MovieDBTest
//
//  Created by Tamron iMac 001 on 7/3/21.
//

import Foundation

struct ApiConfig {
        
    static let BASE_URL = "https://api.themoviedb.org/3"
    static let BASE_IMG_URL = "https://image.tmdb.org/t/p/w500"
    
    enum FilterKey : String{
        
        case data = "data"
        case result = "result"
        case status = "status"
        case results = "results"
        
        func getString() -> String {
            return self.rawValue
        }
    }
    
    enum Movie {
        case upcoming
        case popular
        case detail( _ movieId : Int)
        
        func getUrl() -> String {
            
            let movieBaseUrl = ApiConfig.BASE_URL + "/movie"
            
            switch self {
            case .upcoming:
                return movieBaseUrl + "/upcoming"
            case .popular:
                return movieBaseUrl + "/popular"
            case .detail(let movieId):
                return movieBaseUrl + "/\(movieId)"
            }
        }
    }
    
}
