//
//  PlayerStatusViewModel.swift
//  RPSDCase
//
//  Created by Ensar Batuhan Ünverdi on 4.06.2023.
//

import Foundation

class PlayerStatusViewModel {
    
    private var userShotDatas: [ShotRealm] = []
    
    func fetchDataWith(primaryKey: String ,completion: @escaping ([ShotRealm]?, Error?) -> Void) {
        DatabaseManager.shared.fetchData(withPrimaryKey: primaryKey, objectType: ShotRealm.self) { response in
            if let response = response {
                DispatchQueue.main.async {
                    self.userShotDatas.append(response)
                    completion(self.userShotDatas, nil)
                }
            } else {
                print("An error happened while fetching data from Realm")
            }
        }
    }
}


