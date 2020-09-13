//
//  Error.swift
//  Covid19VIPER
//
//  Created by Smith Huamani Hilario on 8/26/20.
//  Copyright © 2020 Smith Huamaní Hilario. All rights reserved.
//

import Foundation

internal enum APIClientError: Error {//NetworkError
    case noData
    case invalidAuthentication
    case requestTimedout
    case badRequest
    
}
