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
Add the dependency in your `Package.swift` file:
```swift
.package(url: "https://github.com/unique4sourav/StructBasedConstantsMacro.git", from: "1.0.0")
```
Then, include the module:
```
import Constants
```
