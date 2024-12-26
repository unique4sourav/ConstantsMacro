import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Implementation of the `stringify` macro, which takes an expression
/// of any type and produces a tuple containing the value of that expression
/// and the source code that produced the value. For example
///
///     #stringify(x + y)
///
///  will expand to
///
///     (x + y, "x + y")
public struct StringifyMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) -> ExprSyntax {
        guard let argument = node.arguments.first?.expression else {
            fatalError("compiler bug: the macro does not have any arguments")
        }
        
        return "(\(argument), \(literal: argument.description))"
    }
}

@main
struct ConstantsPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
//        StringifyMacro.self,
        ConstantsMacro.self
    ]
}


public struct ConstantsMacro: DeclarationMacro {
    public static func expansion(of node: some SwiftSyntax.FreestandingMacroExpansionSyntax, in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> [SwiftSyntax.DeclSyntax] {
        // 1) Get the raw argument list from the macro call: #Constants(...)
        let arguments = node.arguments
        
        guard arguments.count == 1
        else {
            throw ConstantsError.invalidDictionaryStructure
        }

        // 2) We parse the arguments as a dictionary expression syntax.
        //    This is similar logic to what we had before, but adapted for a freestanding macro.
        guard let dictExpr = arguments.first?.expression.as(DictionaryExprSyntax.self) else {
            throw ConstantsError.notADictionary
        }

        // 3) Build up the declarations from the parsed dictionary.
        //    This part is similar to the old processStructContent code.
        var structDeclarations: [DeclSyntax] = []

        // For each top-level key in the dictionary...
        guard let elementList = dictExpr.content.as(DictionaryElementListSyntax.self) else {
            throw ConstantsError.invalidDictionaryStructure
        }

        for element in elementList {
            guard let keyString = element.key.as(StringLiteralExprSyntax.self)?.representedLiteralValue
            else { throw ConstantsError.unknown }
            
            // We can parse nested dictionaries or direct values.
            if element.value.as(DictionaryExprSyntax.self) != nil {
                // Nested dictionary => process recursively.
                let nestedStructDecl = try processStructContent(
                    structName: keyString,
                    content: element.value
                )
                structDeclarations.append("\(raw: nestedStructDecl)")
            }
            else {
                // Single value => create a struct with one static let
                let valueString = element.value.description.trimmingCharacters(in: .whitespacesAndNewlines)
                let singleValueDecl = DeclSyntax(
                """
                struct \(raw: keyString) {
                    private init() {}
                    static let value = \(raw: valueString)
                }
                """
                )
                structDeclarations.append(singleValueDecl)
            }
        }

        return structDeclarations
    }

    // MARK: - Helper to process nested dictionary content.
    private static func processStructContent(
        structName: String,
        content: ExprSyntax
    ) throws -> String {
        guard let dictionaryContent = content.as(DictionaryExprSyntax.self) else {
            throw ConstantsError.notADictionary
        }
        guard let elementList = dictionaryContent.content.as(DictionaryElementListSyntax.self) else {
            throw ConstantsError.invalidDictionaryStructure
        }

        var members: [String] = []

        for element in elementList {
            guard let key = element.key.as(StringLiteralExprSyntax.self)?.representedLiteralValue
            else { throw ConstantsError.unknown }
            
            let abc = ""
            
            if element.value.as(DictionaryExprSyntax.self) != nil {
                // Recursively process nested dictionaries
                let nestedStructure = try processStructContent(
                    structName: key,
                    content: element.value
                )
                members.append(nestedStructure)
            }
            else {
                let value = element.value.description.trimmingCharacters(in: .whitespacesAndNewlines)
                members.append("static let \(key) = \(value)")
            }
        }

        let joinedMembers = members.joined(separator: "\n")
        // Return a single struct body that contains all the static lets (or nested structs).
        return """
        struct \(structName) {
            private init() {}
        \(joinedMembers)
        }
        """
    }
}
