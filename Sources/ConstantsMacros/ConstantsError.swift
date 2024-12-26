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
    case invalidArgumentCount
    case invalidFormat
    case notADictionary
    case unknown
    
    var description: String {
        switch self {
        case .invalidArgumentCount:
            return "The expression must contain single top level argument."
        case .invalidFormat:
            return "This is not a valid format; 'struct' name is missing."
        case .notADictionary:
            return "The macro's arguments must be a dictionary."
        case .unknown:
            return "Unknown error occurred."
        }
    }
}

