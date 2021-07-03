//
//  ErrorType.swift
//  MovieDBTest
//
//  Created by Tamron iMac 001 on 7/3/21.
//

import Foundation

enum ErrorType: Error {
    case NoInterntError
    case NoDataError
    case KnownError(_ errorMessage: String)
    case UnKnownError
    case TokenExpireError(_ code : Int)
}
