//
//  NetworkHelper.swift
//  RPSDCase
//
//  Created by Ensar Batuhan Ünverdi on 31.05.2023.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

enum ErrorTypes: String, Error {
    case invalidData = "Invalid Data"
    case invalidURL = "Invalid URL"
    case generalError = "An error happened"
}

class NetworkHelper {
    static let shared = NetworkHelper()
    let baseURL = "https://interview-2dlcobr5jq-ue.a.run.app/shots"
}
