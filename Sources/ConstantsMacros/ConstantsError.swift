//
//  File.swift
//  Constants
//
//  Created by Sourav Santra on 26/12/24.
//

// ConstantsError.swift
// Error definitions for the `Constants` macro

import Foundation

enum ConstantsError: Error, CustomStringConvertible {
    case notAStruct
    case notADictionary
    case invalidStructName
    case invalidDictionaryStructure
    case unknown

    var description: String {
        switch self {
        case .notAStruct:
            return "The Constants macro can only be applied to a struct."
        case .notADictionary:
            return "The macro's arguments must be a dictionary."
        case .invalidStructName:
            return "Each struct must have a valid name."
        case .invalidDictionaryStructure:
            return "The dictionary structure provided is invalid."
        case .unknown:
            return "Unknown error occurred."
        }
    }
}

