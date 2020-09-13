//
//  ProfileDataService.swift
//  iOSTest
//
//  Created by Smith Huamani Hilario on 9/12/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

internal class ProfileDataService {
    
    func fetchVideos(completion: @escaping ((Result<[Video]>)-> Void)) {
        
        let resource = Resource(url: "http://www.mocky.io/v2/5e669952310000d2fc23a20e", method: .GET)
        
        APIClient.shared.load(resource) { (result) in
            switch result {
            case .success(let data):
                                
                do {
                    /*let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)*/
                    let video = try JSONDecoder().decode([Video].self, from: data)
                    completion(.success(video))
                } catch {
                    print("Decode data error: ", error.localizedDescription)
                    completion(.failure(error))
                }
        
            case .failure(let error):
                print("Service error: ", error.localizedDescription)
                completion(.failure(error))
            }
        }
        
    }
    
}
