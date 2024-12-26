//
//  ConstantsPlugin.swift
//  Constants
//
//  Created by Sourav Santra on 26/12/24.
//

import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct ConstantsPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        ConstantsMacro.self
    ]
}
