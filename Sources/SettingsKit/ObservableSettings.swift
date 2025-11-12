//
//  ObservableSettings.swift
//  SettingsKit
//
//  Created by Jiaxin Shou on 2024/7/1.
//

import Foundation

/// A macro that generates property accessors for observable settings in an `@Observable` class.
///
/// Use `@ObservableSettings` with the Swift `@Observable` macro to create settings
/// properties that automatically notify observers when values change. This macro
/// generates getter and setter accessors that integrate with Swift's observation system.
///
/// ## Usage
///
/// ```swift
/// @Observable
/// final class SettingsViewModel {
///     @ObservableSettings(UserNameSetting.self, store: .standard)
///     @ObservationIgnored
///     var userName: String
/// }
/// ```
///
/// The macro generates accessors that:
/// - Read values from UserDefaults through the specified `PersistentSettings` type
/// - Write values to UserDefaults when the property is modified
/// - Notify observers through the `@Observable` system's `access(keyPath:)` and `withMutation(keyPath:)` methods
///
/// - Important: This macro requires the property to be marked with `@ObservationIgnored`
///   to prevent conflicts with the generated accessors.
///
/// - Note: This macro is only available on iOS 17.0+, macOS 14.0+, and equivalent
///   platform versions where the `@Observable` macro is supported.
///
/// - Parameters:
///   - type: The `PersistentSettings` type that defines the setting configuration.
///   - store: The UserDefaults instance to use for storage.
@attached(accessor, names: named(get), named(set))
public macro ObservableSettings<T>(
    _ type: T.Type,
    store: UserDefaults
) = #externalMacro(
    module: "SettingsKitMacros",
    type: "ObservableSettingsMacro"
) where T: PersistentSettings
