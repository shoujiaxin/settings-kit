//
//  Extensions.swift
//  SettingsKitMacros
//
//  Created by Jiaxin Shou on 2024/7/4.
//

import SwiftSyntax

/// Extension providing helper properties for variable declarations.
extension VariableDeclSyntax {
    /// The identifier pattern of the first binding in this variable declaration.
    ///
    /// This property extracts the pattern from the first binding, if it exists
    /// and is an identifier pattern.
    var identifierPattern: IdentifierPatternSyntax? {
        bindings.first?.pattern.as(IdentifierPatternSyntax.self)
    }

    /// The identifier token of the first binding in this variable declaration.
    ///
    /// This property provides quick access to the variable's name token,
    /// commonly used in macro implementations.
    var identifier: TokenSyntax? {
        identifierPattern?.identifier
    }
}
