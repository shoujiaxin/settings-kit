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

public struct ObservableSettingsMacro: AccessorMacro {
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

@main
struct SettingsKitMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        ObservableSettingsMacro.self,
    ]
}
