// MARK: - Declaration of the freestanding "Constants" macro.
//
// We mark it as @freestanding(declaration) so it can expand into new declarations.
// We can also specify names: arbitrary if we want the macro to create top-level or nested members.
@freestanding(declaration, names: arbitrary)
public macro Constants(_ dictionary: Any) = #externalMacro(module: "ConstantsMacros", type: "ConstantsMacro")
