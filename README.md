# Struct-Based Constants Macro

A Swift package for creating organized, structured, and reusable constants using Swift macros. This library improves constant management by enabling nested, type-safe, and flexible declarations.

## Why Struct-Based Constants?

Enums in Swift are excellent for unique, type-safe values but impose strict rules on uniqueness, which can be limiting. For example:
- A constant `errorTitle` and `confirmationTitle` both having the value `"Oops!"` would cause a conflict.
- With structs, you can have duplicate values while maintaining clear organization.

### Key Advantages
1. **Nested Constants:** Group constants logically by feature or module.
2. **Duplicate Values Allowed:** No compile-time conflicts for similar values.
3. **Type-Safe:** Access constants with clarity and compile-time safety.
4. **Easy Extension:** Flexible to adapt for app-specific needs.

---

## Features

- Declarative syntax for defining constants using macros.
- Support for nested structures and complex data types like `Set` and `Array`.
- Type-safe access to constants across modules.

---

## Installation

### Swift Package Manager
#### 1. Using `Package.swift` File:
Add the dependency in your `Package.swift` file:
```swift
.package(url: "https://github.com/unique4sourav/StructBasedConstantsMacro.git", from: "1.0.0")
```
Then, include the module:
```
import Constants
```

#### 2. Using Xcode’s "Add Package Dependencies" Option:
If you prefer to add the package through Xcode, follow these steps:

1. Open your Xcode project.
2. Navigate to the project navigator and select your project file at the top of the list.
3. Go to the Package Dependencies tab (usually under the "Swift Packages" section).
4. Click the Add Package button (`+`) at the bottom left.
5. Enter the package URL:

```swift
https://github.com/unique4sourav/StructBasedConstantsMacro.git
```
6. Select the dependency rule:
    - Up to Next Major Version with a version like 1.0.0.
7. Click Add Package to confirm.
   
Xcode will fetch the package and link it to your project automatically. After the setup, you can start using the package by importing it:
```swift
import Constants
```

---

## Usages

### Example 1: App-Wide Constants

```swift
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
print("App Name: \(appName), Base URL: \(baseURL)")
```

After expansion of the macro the end result will be below:
```Swift
struct AppConstants {
    private init() {
    }
    
    static let appName = "MyApp"
    static let maxRetries = 3
    struct NetworkConfig {
        private init() {
        }
        
        static let baseURL = "https://api.example.com"
        static let timeout = 60
    }
}
```

### Example 2: Feature-Specific Constants

```swift
struct AddTaskConstants {
    #Constants([
        "navigationTitle": "Add New Task",
        "favouriteTaskIDs": Set([1, 2, 3]),
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
let alertTitle = AddTaskConstants.Error.alertTitle
print("Title: \(navigationTitle), Alert: \(alertTitle)")
```
After expansion of the macro the end result will be below:

```swift
struct AddTaskConstants {
    private init() {
    }
    
    static let navigationTitle = "Add New Task"
    static let favouriteTaskIDs = Set([1, 2, 3])
    struct Error {
        private init() {
        }
        
        static let alertTitle = "Oops!"
        static let buttonTitle = "Understood"
    }
    struct FieldTitle {
        private init() {
        }
        
        static let dueDate = "Due Date"
        static let priority = "Priority"
        static let note = "Note"
        static let taskBackground = "Task Background"
    }
    struct FieldPrompt {
        private init() {
        }
        
        static let title = "Add a task..."
        static let note = "Here you can add a note about your task."
    }
    struct ToolBarItemTitle {
        private init() {
        }
        
        static let cancel = "Cancel"
        static let save = "Save"
    }
    struct ConfirmationDialougeMessage {
        private init() {
        }
        
        static let discardSaving = "Discard Saving"
    }
}
```

---

## Contributing
We welcome contributions! Follow these steps:

1. Fork the repository.
2. Create a feature branch.
3. Make changes and write clear commit messages.
4. Open a pull request.

---

## Version
See the [Changelog](CHANGELOG.md) for detailed version history.
