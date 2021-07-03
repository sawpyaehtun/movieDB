//
//  ApiClient.swift
//  MovieDBTest
//
//  Created by Tamron iMac 001 on 7/3/21.
//


import Foundation
import Alamofire
import SwiftyJSON
import RxSwift
import RxCocoa
import Reachability
import SystemConfiguration

class ApiClient {
    //MARK:- NETWORK CALLS
    static let shared = ApiClient()
    
    private let APIManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.urlCache = nil
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        let delegate = Session.default.delegate
        let manager = Session.init(configuration: configuration,
                                   delegate: delegate)
        return manager
    }()
    
    
    
    public func request(url : String,
                        method : HTTPMethod = .get,
                        parameters : Parameters = [:],
                        headers : HTTPHeaders = [:] ,
                        isOpenAPI : Bool = false) -> Observable<Data>{
        
        if !ApiClient.checkReachable() {
            return Observable.create { observer in
                observer.onError(ErrorType.NoInterntError)
                return Disposables.create()
            }
        }
        
        var headers = headers
        headers["Content-Type"] = "application/json"
        
        var params = parameters
        params[ApiRequest.ParamKey.apikey.rawValue] = ApiRequest.KEY
        
        let encoding : ParameterEncoding = (method == .get ? URLEncoding.default : JSONEncoding.default)
        
        return Observable.create { observer in
            self.APIManager.request(url, method: method, parameters: params,encoding: encoding, headers: headers).validate().responseJSON { (response) in
                switch response.result {
                case .success:
                                    
                    /* result = Not Null **/
                    if let data = response.data {
                        observer.onNext(data)
                    } else {
                        observer.onError(ErrorType.UnKnownError)
                    }
                    
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
}

//MARK:- CHECK NETWORK
extension ApiClient {
    
    static func isOnline(callback: @escaping (Bool) -> Void){
        //declare this property where it won't go out of scope relative to your listener
        
        let reachability = Reachability()
        
        reachability?.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
                callback(true)
            } else {
                print("Reachable via Cellular")
                callback(true)
            }
        }
        
        reachability?.whenUnreachable = { _ in
            print("Not reachable")
            callback(false)
        }
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
            callback(false)
        }
    }
    
    static func checkReachable() -> Bool{
        
        let reachability = SCNetworkReachabilityCreateWithName(nil, "www.raywenderlich.com")
        
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability!, &flags)
        
        if (isNetworkReachable(with: flags))
        {
            if flags.contains(.isWWAN) {
                return true
            }
                        
            return true
        }
        else if (!isNetworkReachable(with: flags)) {
            return false
        }
        
        return false
    }
    
    static func checkReachable(success : @escaping () -> Void,
                               failure : @escaping () -> Void){
        
        if checkReachable() {
            success()
        }else{
            failure()
        }
        
    }
    
    static func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutUserInteraction = canConnectAutomatically && !flags.contains(.interventionRequired)
        return isReachable && (!needsConnection || canConnectWithoutUserInteraction)
    }
    
}
