//
//  Models.swift
//  RPSDCase
//
//  Created by Ensar Batuhan Ünverdi on 31.05.2023.
//

import Foundation

struct PlayerInformationResponse: Codable {
    let name, surname: String
    let shots: [Shot]
}

struct Shot: Codable {
    let id: String
    let point, segment: Int
    let inOut: Bool
    let shotPosX, shotPosY: Double

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case point, segment
        case inOut = "InOut"
        case shotPosX = "ShotPosX"
        case shotPosY = "ShotPosY"
    }
}
