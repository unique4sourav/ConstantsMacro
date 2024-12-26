// The Swift Programming Language
// https://docs.swift.org/swift-book

/// A macro that produces both a value and a string containing the
/// source code that generated the value. For example,
///
///     #stringify(x + y)
///
/// produces a tuple `(x + y, "x + y")`.
@freestanding(expression)
public macro stringify<T>(_ value: T) -> (T, String) = #externalMacro(module: "ConstantsMacros", type: "StringifyMacro")


// MARK: - Declaration of the freestanding "Constants" macro.
//
// We mark it as @freestanding(declaration) so it can expand into new declarations.
// We can also specify names: arbitrary if we want the macro to create top-level or nested members.
@freestanding(declaration, names: arbitrary)
public macro Constants(_ dictionary: Any) = #externalMacro(module: "ConstantsMacros", type: "ConstantsMacro")
