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
        
        guard let dictExpr = arguments.first?.expression.as(DictionaryExprSyntax.self),
              let elementList = dictExpr.content.as(DictionaryElementListSyntax.self)
        else { throw ConstantsError.notADictionary }
        
        var structDeclarations: [DeclSyntax] = []
        var addedTopLevelPrivateInitializer = false
        for element in elementList {
            guard let key = element.key.as(StringLiteralExprSyntax.self)?.representedLiteralValue
            else { throw ConstantsError.unknown }
            
            let constantsStructure: String
            if let dictionary = element.value.as(DictionaryExprSyntax.self) {
                let nestedStructure = try processStructContent(dictionary)
                constantsStructure = """
                    struct \(key) {
                    private init() {}
                    
                    \(nestedStructure)
                    }
                    """
                structDeclarations.append("\(raw: constantsStructure)")
            }
            else {
                let value = element.value.description.trimmingCharacters(in: .whitespacesAndNewlines)
                if !addedTopLevelPrivateInitializer {
                    constantsStructure = """
                    private init() {}
                    
                    static let \(key) = \(value)
                    """
                    addedTopLevelPrivateInitializer = true
                }
                else {
                    constantsStructure = "static let \(key) = \(value)"
                }
                structDeclarations.append("\(raw: constantsStructure)")
            }
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
            
            let constantsStructure: String
            if let dictionary = element.value.as(DictionaryExprSyntax.self) {
                let nestedStructure = try processStructContent(dictionary)
                constantsStructure = """
                        
                        struct \(key) {
                        private init() {}
                        
                        \(nestedStructure)
                        }
                        """
                members.append(constantsStructure)
            }
            else {
                let value = element.value.description.trimmingCharacters(in: .whitespacesAndNewlines)
                constantsStructure = "static let \(key) = \(value)"
                members.append(constantsStructure)
            }
        }
        
        let joinedMembers = members.joined(separator: "\n")
        return joinedMembers
    }
}
