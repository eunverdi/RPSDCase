//
//  PlayerStatusViewModel.swift
//  RPSDCase
//
//  Created by Ensar Batuhan Ünverdi on 4.06.2023.
//

import UIKit

protocol PlayerStatusViewModelInterface {
    
    var view: PlayerStatusListInterface? { get set }
    
    func fetchDataWith(primaryKey: String ,completion: @escaping ([ShotRealm]?, Error?) -> Void)
    func viewDidLoad()
    func viewWillAppear()
    func initFunction()
    func handleNotification(_ notification: Notification)
}

final class PlayerStatusViewModel {
    
    weak var view: PlayerStatusListInterface?
    private var userShotDatas: [ShotRealm] = []
}


extension PlayerStatusViewModel: PlayerStatusViewModelInterface {
    func handleNotification(_ notification: Notification) {
        view?.handleListNotification(notification)
    }
    
    func viewDidLoad() {
        view?.prepareDidLoad()
    }
    
    func viewWillAppear() {
        view?.prepareViewWillAppear()
    }
    
    func initFunction() {
        view?.prepareInit()
    }
    
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


