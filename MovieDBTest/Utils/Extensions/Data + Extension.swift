//
//  Data + Extension.swift
//  MovieDBTest
//
//  Created by Tamron iMac 001 on 7/3/21.
//

import SwiftyJSON

extension Data {
        
    func decode<T>(modelType: T.Type,
                   success : @escaping (T) -> Void,
                   failure : @escaping (String) -> Void) where T : Decodable{
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let result = try decoder.decode(modelType, from: self)
            success(result)
        } catch let jsonError{
            print("an error occur while decoding . . . \(jsonError) >>>>> \(modelType)")
            failure(jsonError.localizedDescription)
        }
    }
    
    func decode<T>(modelType: T.Type) -> T? where T : Decodable{
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let result = try decoder.decode(modelType, from: self)
            return result
        } catch let jsonError{
            print("an error occur while decoding . . . \(jsonError.localizedDescription) >>>>> \(modelType)")
            return nil
        }
    }
    
    func singleDecode<T>(key : ApiConfig.FilterKey, type : T.Type) -> T? {
        let json = JSON(self)
        return json[key.getString()].rawValue as? T
    }
    
    func toJsonString() -> String? {
        let json = JSON(self)
        let jsonString = json.rawString()
        return jsonString
    }
    
    func filterByKey(keys : ApiConfig.FilterKey...) -> Data {
        
        var json = JSON(self)
        
        keys.forEach { (key) in
            json = json[key.getString()]
        }
        
        let jsonString = json.rawString()
        let data = Data(jsonString!.utf8)
        return data
    }

}
