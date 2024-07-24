//
//  Diagnostics.swift
//  SettingsKitMacros
//
//  Created by Jiaxin Shou on 2024/7/4.
//

import SwiftDiagnostics
import SwiftSyntax

private let domain: String = "SettingsKit"

// MARK: - DiagnosticMessage

struct SettingsKitDiagnosticMessage: DiagnosticMessage {
    let message: String

    let diagnosticID: MessageID

    let severity: DiagnosticSeverity

    init(_ message: String, id: String = #function, severity: DiagnosticSeverity = .error) {
        self.message = message
        diagnosticID = .init(domain: domain, id: id)
        self.severity = severity
    }
}

extension DiagnosticMessage where Self == SettingsKitDiagnosticMessage {
    static var invalidVariableType: Self {
        .init("invalid variable type")
    }
}

// MARK: - FixItMessage

struct SettingsKitFixItMessage: FixItMessage {
    let message: String

    let fixItID: MessageID

    init(_ message: String, id: String = #function) {
        self.message = message
        fixItID = .init(domain: domain, id: id)
    }
}

// MARK: - Diagnostics

extension Diagnostic {
    static func invalidVariableType(node: VariableDeclSyntax) -> Self {
        .init(
            node: node,
            message: .invalidVariableType,
            fixIt: .replace(
                message: SettingsKitFixItMessage("replace `\(node.bindingSpecifier.trimmed)` with `var`"),
                oldNode: node.bindingSpecifier,
                newNode: SwiftSyntax.TokenSyntax.keyword(.var)
            )
        )
    }
}
