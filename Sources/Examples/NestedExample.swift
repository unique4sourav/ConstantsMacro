//
//  NestedExample.swift
//  Constants
//
//  Created by Sourav Santra on 26/12/24.
//

import Constants

struct AddTaskConstants {
    #Constants([
        "navigationTitle": "Add New Task",
        "Error": [
            "alertTitle": "Oops!",
            "buttonTitle": "Understood"
        ]
    ])
}

let navigationTitle = AddTaskConstants.navigationTitle
print("Navigation Title: \(navigationTitle)")
