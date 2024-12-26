import Constants


struct AppConstants {
    #Constants([
        "appName": "MyApp",
        "maxRetries": 3,
        
        "NetworkConfig": [
            "baseURL": "https://api.example.com",
            "timeout": 60
        ]
    ])
    
}

let appName = AppConstants.appName
let baseURL = AppConstants.NetworkConfig.baseURL



struct AddTaskConstants {
    #Constants([
        "navigationTitle": "Add New Task",
        "Error": [
            "alertTitle": "Oops!",
            "buttonTitle": "Understood"
        ],
        "FieldTitle": [
            "dueDate": "Due Date",
            "priority": "Priority",
            "note": "Note",
            "taskBackground": "Task Background"
        ],
        "FieldPrompt": [
            "title": "Add a task...",
            "note": "Here you can add a note about your task."
        ],
        "ToolBarItemTitle": [
            "cancel": "Cancel",
            "save": "Save"
        ],
        "ConfirmationDialougeMessage": [
            "discardSaving": "Discard Saving"
        ]
    ])
}

let navigationTitle = AddTaskConstants.navigationTitle
let confirmationMessage = AddTaskConstants.ConfirmationDialougeMessage.discardSaving
