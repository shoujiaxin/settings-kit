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
        in context: some MacroExpansionContext
    ) throws -> [AccessorDeclSyntax] {
        print(node, declaration, context)
        return [
            """
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
