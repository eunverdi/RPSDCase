//
//  NetworkManager.swift
//  RPSDCase
//
//  Created by Ensar Batuhan Ünverdi on 31.05.2023.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func request<T: Codable>(type: T.Type, url: String, method: HTTPMethods, completion: @escaping((Result<T, ErrorTypes>) -> ())) {
        let session = URLSession.shared
        if let url = URL(string: url) {
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            
            let dataTask = session.dataTask(with: request) { data, response, error in
                if let _ = error {
                    completion(.failure(.generalError))
                }
                
                if let data = data {
                    self.handleResponse(data: data) { response in
                        completion(response)
                    }
                }
            }
            dataTask.resume()
        }
        
    }
    
    fileprivate func handleResponse<T: Codable>(data: Data, completion: @escaping((Result<T, ErrorTypes>) -> ())) {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch {
            print(error)
            completion(.failure(.invalidData))
        }
    }
}
