//
//  DatabaseManager.swift
//  RPSDCase
//
//  Created by Ensar Batuhan Ünverdi on 31.05.2023.
//

import RealmSwift

class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private init() {}
    
    func saveData<T: Object>(objects: [T]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(objects, update: .all)
            }
            print("Data succesfully saved to Realm")
        } catch {
            print("Error saving data to Realm: \(error)")
        }
    }
    
    func saveData<T: Object>(object: T) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(object, update: .all)
            }
            print("Data successfully saved to Realm")
        } catch {
            print("Error saving data to Realm: \(error)")
        }
    }
    
    func fetchData<T: Object>(withPrimaryKey primaryKey: String, objectType: T.Type, completion: @escaping (T?) -> Void) {
        do {
            let realm = try Realm()
            
            guard let primaryKeyPropertyName = objectType.primaryKey() else {
                print("Primary key is not defined for the object type.")
                completion(nil)
                return
            }
            
            let predicate = NSPredicate(format: "\(primaryKeyPropertyName) = %@", primaryKey)
            let results = realm.objects(objectType).filter(predicate)
            
            let result = results.first
            completion(result)
        } catch {
            print("Error fetching data from Realm: \(error)")
            completion(nil)
        }
    }

    
    func fetchAllData<T: Object>(type: T.Type, completion: @escaping (Results<T>?, Error?) -> Void) {
        do {
            let realm = try Realm()
            let results = realm.objects(type)
            print("Data succesfully fetch from Realm")
            completion(results, nil)
        } catch {
            print("Error fetching data from Realm: \(error)")
            completion(nil, error)
        }
    }
    
    func deleteObject<T: Object>(type: T.Type, primaryKey: String) {
        do {
            let realm = try Realm()
            if let object = realm.object(ofType: type, forPrimaryKey: primaryKey) {
                try realm.write {
                    realm.delete(object)
                }
            }
            print("Data succesfully delete from Realm")
        } catch {
            print("Error deleting object from Realm: \(error)")
        }
    }
    
    func deleteAllData() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
            print("All data succesfully delete from Realm")
        } catch {
            print("Error deleting data from Realm: \(error)")
        }
    }
}
