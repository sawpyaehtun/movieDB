//
//  DBManager.swift
//  MovieDBTest
//
//  Created by MyMacBookPro on 03/07/2021.
//

import Foundation
import RealmSwift

enum  ROname : String {
    case PopularMovieRO
    case UpComingMovieRO
    case FavouriteMovieRO
}

class DBManager {
    private var   database:Realm
    static let   sharedInstance = DBManager()
    
    private init() {
        database = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
    }
    
    //MARK:- retrieve all from of one model
    func getDataFromDB(roName : ROname) ->   [Object]! {
        switch roName {
        case .UpComingMovieRO:
            let results: Results<UpComingMovieRO> =   database.objects(UpComingMovieRO.self)
            return Array(results)
        case .PopularMovieRO:
            let results: Results<PopularMovieRO> =   database.objects(PopularMovieRO.self)
            return Array(results)
        case .FavouriteMovieRO:
            let results: Results<FavouriteMovieRO> =   database.objects(FavouriteMovieRO.self)
            return Array(results)
        }
    }
    
    
    // MARK:- UPDATE
    func update(object : Object, dictiionary : [String : Any?]) {
        do {
            try database.write {
                for (key,value) in dictiionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch let dberror {
            print("Realm Debug : error occur when updating \(dberror.localizedDescription)")
        }
    }
    
    //MARK: create or insert to database
    func addData(object : Object) {
        do{
            try database.write {
                database.add(object,update: .modified)
                print("completely added . . .")
            }
        } catch {
            print("Realm Debug : error occur when adding \(error)")
        }
    }
    
    func addData(objectArray: [Object])   {
        do{
            try database.write {
                database.add(objectArray, update: .modified)
                print("completely added . . .")
            }
        } catch {
            print("Realm Debug : error occur when adding \(error)")
        }
    }
    
    //MARK:- retrieve by predicate
    func getObjectById(id : Int,roName : ROname) -> Object? {
        let predicate = NSPredicate(format: "id == \(id)")
        
        switch roName {
        case .PopularMovieRO:
            let result = database.objects(PopularMovieRO.self).filter(predicate)
            return result.count > 0 ? result[0] : nil
        case .UpComingMovieRO:
            let result = database.objects(UpComingMovieRO.self).filter(predicate)
            return result.count > 0 ? result[0] : nil
        case .FavouriteMovieRO:
            let result = database.objects(FavouriteMovieRO.self).filter(predicate)
            return result.count > 0 ? result[0] : nil
        }
        
    }
    
    func getObjArrayByKey(key : String,property : String,roName : ROname) -> [Object]? {
        let predicate = NSPredicate(format: "\(property) == \(key)")
        
        switch roName {
        case .PopularMovieRO:
            let result = database.objects(PopularMovieRO.self).filter(predicate)
            return result.count > 0 ? Array(result) : nil
        case .UpComingMovieRO:
            let result = database.objects(UpComingMovieRO.self).filter(predicate)
            return result.count > 0 ? Array(result) : nil
        case .FavouriteMovieRO:
            let result = database.objects(FavouriteMovieRO.self).filter(predicate)
            return result.count > 0 ? Array(result) : nil
        }
        
    }
    
    func deleteData(id : Int,roName : ROname){
        do {
            try database.write {
                if let object = getObjectById(id: id, roName: roName) {
                    database.delete(object)
                    print("Successfully Deleted")
                }
            }
        }catch _ {
            print("Fail to delete")
            
        }
        
    }
    
}
