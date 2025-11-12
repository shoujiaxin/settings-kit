//
//  SettingsKitMacro.swift
//  SettingsKitMacros
//
//  Created by Jiaxin Shou on 2024/7/1.
//

import SwiftCompilerPlugin
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// The macro implementation for `@ObservableSettings`.
///
/// This macro generates getter and setter accessors that integrate with Swift's
/// `@Observable` system to provide reactive settings stored in UserDefaults.
///
/// The generated accessors:
/// - Use `access(keyPath:)` in the getter to register observation dependencies
/// - Use `withMutation(keyPath:)` in the setter to notify observers of changes
/// - Delegate actual storage and retrieval to the `PersistentSettings` type
public struct ObservableSettingsMacro: AccessorMacro {
    /// Expands the macro to generate property accessors.
    ///
    /// This method generates a getter and setter that work with Swift's `@Observable`
    /// system to provide reactive updates when the setting value changes.
    ///
    /// - Parameters:
    ///   - node: The attribute syntax node representing the macro usage.
    ///   - declaration: The declaration the macro is attached to (must be a variable declaration).
    ///   - context: The macro expansion context.
    ///
    /// - Returns: An array of accessor declarations (getter and setter).
    ///
    /// - Throws: `DiagnosticsError` if the macro is applied to a non-variable declaration.
    public static func expansion(
        of node: AttributeSyntax,
        providingAccessorsOf declaration: some DeclSyntaxProtocol,
        in _: some MacroExpansionContext
    ) throws -> [AccessorDeclSyntax] {
        guard let variableDeclaration = declaration.as(VariableDeclSyntax.self),
              let identifier = variableDeclaration.identifier?.trimmed
        else {
            return []
        }

        guard let arguments = node.arguments?.as(LabeledExprListSyntax.self),
              let settingsType = arguments.first?.expression.as(MemberAccessExprSyntax.self)?.base?.trimmed,
              let store = arguments.last?.expression.trimmed
        else {
            return []
        }

        guard variableDeclaration.bindingSpecifier.tokenKind == .keyword(.var)
        else {
            throw DiagnosticsError(diagnostics: [.invalidVariableType(node: variableDeclaration)])
        }

        let getAccessor: AccessorDeclSyntax =
            """
            get {
                access(keyPath: \\.\(identifier))
                return \(settingsType).value(in: \(store))
            }
            """

        let setAccessor: AccessorDeclSyntax =
            """
            set {
                withMutation(keyPath: \\.\(identifier)) {
                    \(settingsType).set(newValue, to: \(store))
                }
            }
            """

        return [getAccessor, setAccessor]
    }
}

/// The compiler plugin that provides the SettingsKit macros.
///
/// This plugin registers all macros available in the SettingsKit package,
/// making them available for use in Swift code that imports SettingsKit.
@main
struct SettingsKitMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        ObservableSettingsMacro.self,
    ]
}
