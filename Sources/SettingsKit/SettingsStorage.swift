//
//  SettingsStorage.swift
//  SettingsKit
//
//  Created by Jiaxin Shou on 2024/6/3.
//

import Foundation

/// A property wrapper that provides type-safe access to persistent settings stored in UserDefaults.
///
/// Use `@SettingsStorage` to create properties that automatically read from and write to
/// UserDefaults using a `PersistentSettings` conforming type for configuration.
///
/// ## Usage
///
/// ```swift
/// struct UserNameSetting: PersistentSettings {
///     typealias Value = String
///     static let defaultValue = "Anonymous"
///     static let userDefaultsKey = "userName"
/// }
///
/// @SettingsStorage(UserNameSetting.self)
/// var userName: String
/// ```
///
/// The property automatically persists changes to UserDefaults and retrieves
/// the stored value (or the default value if none exists) when accessed.
///
/// - Note: The `UserDefaults` class is thread-safe, making this property wrapper
///   safe to use across multiple threads.
@frozen
@propertyWrapper
public struct SettingsStorage<T> where T: PersistentSettings {
    /// The current value of the setting.
    ///
    /// When read, this property retrieves the value from UserDefaults using the
    /// associated `PersistentSettings` type. When written, it stores the new
    /// value to UserDefaults.
    public var wrappedValue: T.Value {
        get {
            T.value(in: store)
        }
        set {
            T.set(newValue, to: store)
        }
    }

    /// The user defaults store to read and write to.
    /// The `UserDefaults` class is thread-safe, so it's safe to be marked as `nonisolated(unsafe)`.
    private nonisolated(unsafe) let store: UserDefaults

    /// Creates a new settings storage instance.
    ///
    /// - Parameters:
    ///   - type: The `PersistentSettings` type that defines how the value
    ///     is stored and retrieved from UserDefaults.
    ///   - store: The UserDefaults instance to use for storage. If `nil`,
    ///     the standard UserDefaults instance is used.
    public init(_: T.Type, store: UserDefaults? = nil) {
        self.store = store ?? .standard
    }
}

extension SettingsStorage: Sendable where T.Value: Sendable {}
