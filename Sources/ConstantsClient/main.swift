import Constants

//let a = 17
//let b = 25
//
//let (result, code) = #stringify(a + b)
//
//print("The value \(result) was produced by the code \"\(code)\"")


#Constants(
    [
        "AppConstants": [
            "appName": "\"MyApp\"",
            "maxRetries": 3,
            "NetworkConfig": [
                "baseURL": "\"https://api.example.com\"",
                "timeout": 60
            ]
        ]
    ]
)

