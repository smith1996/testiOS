//
//  APIClient.swift
//  Covid19VIPER
//
//  Created by Smith Huamani Hilario on 8/26/20.
//  Copyright © 2020 Smith Huamaní Hilario. All rights reserved.
//

import Foundation

internal class APIClient {
    
    static let shared = APIClient()
    
    public func load(_ resource: Resource, result: @escaping ((Result<Data>) -> Void)) {
        
        let request = URLRequest(resource)
                
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                        
            guard let `response` = response as? HTTPURLResponse else {
                result(.failure(error!))
                return
            }
            
            guard response.statusCode == 200 else {
                result(.failure(error!))
                return
            }
            
            guard let `data` = data else {
                result(.failure(APIClientError.noData))
                return
            }
            
            if let `error` = error {
                result(.failure(error))
                return
            }
                
            DispatchQueue.main.async {
                result(.success(data))
            }
        }
        task.resume()
    }
}
