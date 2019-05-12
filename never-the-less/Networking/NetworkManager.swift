//
//  NetworkManager.swift
//  never-the-less
//
//  Created by Philip on 5/12/19.
//  Copyright © 2019 Philip. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        guard let escapedURLString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: escapedURLString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                debugPrint(error)
                completion(nil, error)
            }
            
            guard let data = data else { completion(nil, nil); return }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(result, nil)
            } catch let error {
                debugPrint(error)
                completion(nil, error)
            }
            
            }.resume()
    }
}
