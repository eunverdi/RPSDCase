//
//  RealmModel.swift
//  RPSDCase
//
//  Created by Ensar Batuhan Ünverdi on 3.06.2023.
//

import RealmSwift

class PlayerInformationResponseRealm: Object {
    @Persisted var name: String
    @Persisted var surname: String
    @Persisted var shots: List<ShotRealm>
    
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
    convenience init(name: String, surname: String, shots: [Shot]) {
        self.init()
        self.name = name
        self.surname = surname
        
        let realmShots = shots.map { ShotRealm(value: $0) }
        let shotList = List<ShotRealm>()
        shotList.append(objectsIn: realmShots)
        self.shots = shotList
    }
}

class ShotRealm: Object {
    @Persisted var id: String
    @Persisted var point: Int
    @Persisted var segment: Int
    @Persisted var inOut: Bool
    @Persisted var shotPosX: Double
    @Persisted var shotPosY: Double
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(shot: Shot) {
        self.init()
        self.id = shot.id
        self.point = shot.point
        self.segment = shot.segment
        self.inOut = shot.inOut
        self.shotPosX = shot.shotPosX
        self.shotPosY = shot.shotPosY
    }
}

class VideoRealm: Object {
    @Persisted var videoURL: String = ""
    @Persisted var point: Int = 0
    @Persisted var segment: Int = 0
    @Persisted var inOut: Bool = false
    @Persisted var shotPosX: Double = 0.0
    @Persisted var shotPosY: Double = 0.0
    
    override static func primaryKey() -> String? {
        return "videoURL"
    }
}
