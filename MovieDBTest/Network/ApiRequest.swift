//
//  ApiRequest.swift
//  MovieDBTest
//
//  Created by Tamron iMac 001 on 7/3/21.
//

import Foundation

struct ApiRequest {
    
    static let KEY = "3ea4500e51ab3b0358547f472e44d5fc"
    static let SESSION_ID = "1c9cf3211a9cd464048cf6a9a001bd6166f98ded"
        
    enum ParamKey : String{
        case page = "page"
        case apikey = "api_key"
    }
    
    enum Movie {
        case getMovieList( _ pageId : Int)
        
        func getParams() -> [String : Any]{
            switch self {
            case .getMovieList(let pageId):
                return [
                    ApiRequest.ParamKey.page.rawValue : pageId as Any
                ]
            }
        }
    }
    
}
