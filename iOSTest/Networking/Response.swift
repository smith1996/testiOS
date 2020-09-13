//
//  Response.swift
//  Covid19VIPER
//
//  Created by Smith Huamani Hilario on 8/26/20.
//  Copyright © 2020 Smith Huamaní Hilario. All rights reserved.
//

import Foundation

internal enum Result<T> {
    case success(T)
    case failure(Error)
}
