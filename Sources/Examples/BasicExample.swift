//
//  BasicExample.swift
//  Constants
//
//  Created by Sourav Santra on 26/12/24.
//

import Constants

struct AppConstants {
    #Constants([
        "appName": "MyApp",
        "maxRetries": 3
    ])
}

let appName = AppConstants.appName
print("App Name: \(appName)")
