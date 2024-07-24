//
//  Extensions.swift
//  SettingsKitMacros
//
//  Created by Jiaxin Shou on 2024/7/4.
//

import SwiftSyntax

extension VariableDeclSyntax {
    var identifierPattern: IdentifierPatternSyntax? {
        bindings.first?.pattern.as(IdentifierPatternSyntax.self)
    }

    var identifier: TokenSyntax? {
        identifierPattern?.identifier
    }
}
