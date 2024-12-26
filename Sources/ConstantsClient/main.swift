import Constants

//let a = 17
//let b = 25
//
//let (result, code) = #stringify(a + b)
//
//print("The value \(result) was produced by the code \"\(code)\"")


#Constants([
        "AppConstants": [
            "appName": "MyApp",
            "maxRetries": 3,
            
            "NetworkConfig": [
                "baseURL": "https://api.example.com",
                "timeout": 60
            ]
        ]
    ])


//#Constants([
//    "AddTaskConstant": [
//        "navigationTitle": "Add New Task",
//        "Error": [
//            "alertTitle": "Oops!",
//            "buttonTitle": "Understood"
//        ],
//        "FieldTitle": [
//            "dueDate": "Due Date",
//            "priority": "Priority",
//            "note": "Note",
//            "taskBackground": "Task Background"
//        ],
//        "FieldPrompt": [
//            "title": "Add a task...",
//            "note": "Here you can add a note about your task."
//        ],
//        "ToolBarItemTitle": [
//            "cancel": "Cancel",
//            "save": "Save"
//        ],
//        "ConfirmationDialougeMessage": [
//            "discardSaving": "Discard Saving"
//        ]
//    ]
//])
