//
//  Video.swift
//  iOSTest
//
//  Created by Smith Huamani Hilario on 9/12/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation

internal struct Video: Codable {
    
    var profile: Profile?
    var description: String
    var recordVideo: String?
    var previewImage: String?

    public enum CodingKeys: String, CodingKey {
        case profile = "profile"
        case description = "description"
        case recordVideo = "record_video"
        case previewImage = "preview_img"
    }
}

internal struct Profile: Codable {
    
    var name: String
    var username: String
    var image: String?

    public enum CodingKeys: String, CodingKey {
        case name = "name"
        case username = "user_name"
        case image = "img"
    }
}
