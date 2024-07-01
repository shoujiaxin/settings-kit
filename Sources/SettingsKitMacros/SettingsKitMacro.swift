//
//  SettingsKitMacro.swift
//  SettingsKitMacros
//
//  Created by Jiaxin Shou on 2024/7/1.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct ObservableSettingsMacro: AccessorMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingAccessorsOf declaration: some DeclSyntaxProtocol,
        in _: some MacroExpansionContext
    ) throws -> [AccessorDeclSyntax] {
        guard let arguments = node.arguments?.as(LabeledExprListSyntax.self),
              arguments.count == 2
        else {
            // TODO: Throw an error.
            return []
        }

        guard let typeName = arguments.first?.expression.as(MemberAccessExprSyntax.self)?.base,
              let store = arguments.last?.expression
        else {
            // TODO: Throw an error.
            return []
        }

        guard let bindings = declaration.as(VariableDeclSyntax.self)?.bindings,
              bindings.count == 1
        else {
            // TODO: Throw an error.
            return []
        }

        guard let propertyName = bindings.first?.pattern
        else {
            // TODO: Throw an error.
            return []
        }

        return [
            """
            get {
                access(keyPath: \\.\(propertyName))
                return \(typeName).value(in: \(store))
            }
            set {
                withMutation(keyPath: \\.\(propertyName)) {
                    \(typeName).set(newValue, to: \(store))
                }
            }
            """,
        ]
    }
}

@main
struct SettingsKitMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        ObservableSettingsMacro.self,
    ]
}
