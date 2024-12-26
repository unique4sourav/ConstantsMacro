import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros


public struct ConstantsMacro: DeclarationMacro {
    public static func expansion(
        of node: some SwiftSyntax.FreestandingMacroExpansionSyntax,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    )
    throws -> [SwiftSyntax.DeclSyntax] {
        let arguments = node.arguments
        
        guard arguments.count == 1
        else { throw ConstantsError.invalidArgumentCount }
        
        guard let dictExpr = arguments.first?.expression.as(DictionaryExprSyntax.self)
        else { throw ConstantsError.notADictionary }
        
        var structDeclarations: [DeclSyntax] = []
        
        guard let elementList = dictExpr.content.as(DictionaryElementListSyntax.self)
        else { throw ConstantsError.invalidArgumentCount }
        
        for element in elementList {
            guard let key = element.key.as(StringLiteralExprSyntax.self)?.representedLiteralValue
            else { throw ConstantsError.unknown }
            
            guard let dictionary = element.value.as(DictionaryExprSyntax.self)
            else { throw ConstantsError.invalidFormat }
            
            let nestedStructure = try processStructContent(dictionary)
            let finalStructure = """
                    struct \(key) {
                    private init() {}
                    
                    \(nestedStructure)
                    }
                    """
            structDeclarations.append("\(raw: finalStructure)")
        }
        
        return structDeclarations
    }
    
    // MARK: - Helper to process nested dictionary content.
    private static func processStructContent(_ content: DictionaryExprSyntax) throws -> String {
        guard let elementList = content.content.as(DictionaryElementListSyntax.self)
        else { throw ConstantsError.invalidArgumentCount }
        
        var members: [String] = []
        
        for element in elementList {
            guard let key = element.key.as(StringLiteralExprSyntax.self)?.representedLiteralValue
            else { throw ConstantsError.unknown }
            
            if let dictionary = element.value.as(DictionaryExprSyntax.self) {
                let nestedStructure = try processStructContent(dictionary)
                let finalStructure = """
                        
                        struct \(key) {
                        private init() {}
                        
                        \(nestedStructure)
                        }
                        """
                members.append(finalStructure)
            }
            else {
                let value = element.value.description.trimmingCharacters(in: .whitespacesAndNewlines)
                members.append("static let \(key) = \(value)")
            }
        }
        
        let joinedMembers = members.joined(separator: "\n")
        return joinedMembers
    }
}
