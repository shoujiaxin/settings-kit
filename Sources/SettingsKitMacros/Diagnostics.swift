//
//  Diagnostics.swift
//  SettingsKitMacros
//
//  Created by Jiaxin Shou on 2024/7/4.
//

import SwiftDiagnostics
import SwiftSyntax

/// The domain identifier for SettingsKit diagnostics.
private let domain: String = "SettingsKit"

// MARK: - DiagnosticMessage

/// A diagnostic message type for SettingsKit macro errors and warnings.
///
/// This type conforms to `DiagnosticMessage` and provides structured error
/// reporting for macro expansion issues.
struct SettingsKitDiagnosticMessage: DiagnosticMessage {
    /// The human-readable error message.
    let message: String

    /// A unique identifier for this diagnostic type.
    let diagnosticID: MessageID

    /// The severity level of this diagnostic (error, warning, or note).
    let severity: DiagnosticSeverity

    /// Creates a new diagnostic message.
    ///
    /// - Parameters:
    ///   - message: The error message to display.
    ///   - id: A unique identifier for this diagnostic. Defaults to the calling function name.
    ///   - severity: The severity level. Defaults to `.error`.
    init(_ message: String, id: String = #function, severity: DiagnosticSeverity = .error) {
        self.message = message
        diagnosticID = .init(domain: domain, id: id)
        self.severity = severity
    }
}

extension DiagnosticMessage where Self == SettingsKitDiagnosticMessage {
    /// A diagnostic message for when a macro is applied to an invalid variable type.
    ///
    /// This error is emitted when `@ObservableSettings` is used on a `let` constant
    /// instead of a `var` variable.
    static var invalidVariableType: Self {
        .init("invalid variable type")
    }
}

// MARK: - FixItMessage

/// A fix-it message type for suggesting code corrections.
///
/// This type provides structured suggestions for fixing diagnostic errors
/// in SettingsKit macros.
struct SettingsKitFixItMessage: FixItMessage {
    /// The human-readable fix-it suggestion message.
    let message: String

    /// A unique identifier for this fix-it type.
    let fixItID: MessageID

    /// Creates a new fix-it message.
    ///
    /// - Parameters:
    ///   - message: The fix-it suggestion to display.
    ///   - id: A unique identifier for this fix-it. Defaults to the calling function name.
    init(_ message: String, id: String = #function) {
        self.message = message
        fixItID = .init(domain: domain, id: id)
    }
}

// MARK: - Diagnostics

/// Extension providing factory methods for creating SettingsKit diagnostics.
extension Diagnostic {
    /// Creates a diagnostic for invalid variable type usage.
    ///
    /// This diagnostic is emitted when `@ObservableSettings` is applied to a constant
    /// (`let`) instead of a variable (`var`). It includes a fix-it suggesting the
    /// replacement of `let` with `var`.
    ///
    /// - Parameter node: The variable declaration node with the invalid type.
    /// - Returns: A diagnostic with an associated fix-it.
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
