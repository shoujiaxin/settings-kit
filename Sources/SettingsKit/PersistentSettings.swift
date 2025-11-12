//
//  PersistentSettings.swift
//  SettingsKit
//
//  Created by Jiaxin Shou on 2024/6/3.
//

import Foundation

// MARK: - Interfaces

/// A protocol that defines persistent settings stored in UserDefaults.
///
/// Conform to this protocol to create type-safe settings that are automatically
/// persisted to and retrieved from UserDefaults. The protocol provides default
/// implementations for common value types including String, Int, Bool, Double,
/// Float, Data, URL, and RawRepresentable types.
///
/// ## Topics
///
/// ### Creating Custom Settings
///
/// To create a custom setting, define a type that conforms to `PersistentSettings`:
///
/// ```swift
/// struct UserNameSetting: PersistentSettings {
///     typealias Value = String
///     static let defaultValue = "Anonymous"
///     static let userDefaultsKey = "userName"
/// }
/// ```
///
/// ### Supported Value Types
///
/// The following types have built-in support:
/// - `String`
/// - `Int`, `Float`, `Double`
/// - `Bool`
/// - `Data`
/// - `URL`
/// - `RawRepresentable` types with `Int` or `String` raw values
public protocol PersistentSettings<Value>: Sendable where Value: Sendable {
    /// The type of value stored in this setting.
    associatedtype Value

    /// The default value returned when no value has been set in UserDefaults.
    static var defaultValue: Value { get }

    /// The key used to store and retrieve the value from UserDefaults.
    static var userDefaultsKey: String { get }

    /// Retrieves the current value from the specified UserDefaults store.
    ///
    /// - Parameter store: The UserDefaults instance to read from.
    /// - Returns: The stored value, or `defaultValue` if no value exists.
    static func value(in store: UserDefaults) -> Value

    /// Stores a new value to the specified UserDefaults store.
    ///
    /// - Parameters:
    ///   - value: The value to store.
    ///   - store: The UserDefaults instance to write to.
    static func set(_ value: Value, to store: UserDefaults)
}

// MARK: - Default Implementations

/// Default implementation for URL values.
///
/// Provides automatic storage and retrieval of URL values from UserDefaults.
public extension PersistentSettings where Value == URL {
    static func value(in store: UserDefaults) -> Value {
        store.url(forKey: userDefaultsKey) ?? defaultValue
    }

    static func set(_ value: Value, to store: UserDefaults) {
        store.set(value, forKey: userDefaultsKey)
    }
}

/// Default implementation for String values.
///
/// Provides automatic storage and retrieval of String values from UserDefaults.
public extension PersistentSettings where Value == String {
    static func value(in store: UserDefaults) -> Value {
        store.string(forKey: userDefaultsKey) ?? defaultValue
    }

    static func set(_ value: Value, to store: UserDefaults) {
        store.set(value, forKey: userDefaultsKey)
    }
}

/// Default implementation for Data values.
///
/// Provides automatic storage and retrieval of Data values from UserDefaults.
public extension PersistentSettings where Value == Data {
    static func value(in store: UserDefaults) -> Value {
        store.data(forKey: userDefaultsKey) ?? defaultValue
    }

    static func set(_ value: Value, to store: UserDefaults) {
        store.set(value, forKey: userDefaultsKey)
    }
}

/// Default implementation for Bool values.
///
/// Provides automatic storage and retrieval of Bool values from UserDefaults.
public extension PersistentSettings where Value == Bool {
    static func value(in store: UserDefaults) -> Value {
        store.object(forKey: userDefaultsKey).flatMap { $0 as? Value } ?? defaultValue
    }

    static func set(_ value: Value, to store: UserDefaults) {
        store.set(value, forKey: userDefaultsKey)
    }
}

/// Default implementation for Int values.
///
/// Provides automatic storage and retrieval of Int values from UserDefaults.
public extension PersistentSettings where Value == Int {
    static func value(in store: UserDefaults) -> Value {
        store.object(forKey: userDefaultsKey).flatMap { $0 as? Value } ?? defaultValue
    }

    static func set(_ value: Value, to store: UserDefaults) {
        store.set(value, forKey: userDefaultsKey)
    }
}

/// Default implementation for Float values.
///
/// Provides automatic storage and retrieval of Float values from UserDefaults.
public extension PersistentSettings where Value == Float {
    static func value(in store: UserDefaults) -> Value {
        store.object(forKey: userDefaultsKey).flatMap { $0 as? Value } ?? defaultValue
    }

    static func set(_ value: Value, to store: UserDefaults) {
        store.set(value, forKey: userDefaultsKey)
    }
}

/// Default implementation for Double values.
///
/// Provides automatic storage and retrieval of Double values from UserDefaults.
public extension PersistentSettings where Value == Double {
    static func value(in store: UserDefaults) -> Value {
        store.object(forKey: userDefaultsKey).flatMap { $0 as? Value } ?? defaultValue
    }

    static func set(_ value: Value, to store: UserDefaults) {
        store.set(value, forKey: userDefaultsKey)
    }
}

/// Default implementation for RawRepresentable types with Int raw values.
///
/// Provides automatic storage and retrieval of enum or other RawRepresentable
/// types that use Int as their raw value. The raw value is stored in UserDefaults
/// and automatically converted back to the original type when retrieved.
public extension PersistentSettings where Value: RawRepresentable, Value.RawValue == Int {
    static func value(in store: UserDefaults) -> Value {
        store.object(forKey: userDefaultsKey).flatMap { $0 as? Value.RawValue }.flatMap(Value.init(rawValue:)) ?? defaultValue
    }

    static func set(_ value: Value, to store: UserDefaults) {
        store.set(value.rawValue, forKey: userDefaultsKey)
    }
}

/// Default implementation for RawRepresentable types with String raw values.
///
/// Provides automatic storage and retrieval of enum or other RawRepresentable
/// types that use String as their raw value. The raw value is stored in UserDefaults
/// and automatically converted back to the original type when retrieved.
public extension PersistentSettings where Value: RawRepresentable, Value.RawValue == String {
    static func value(in store: UserDefaults) -> Value {
        store.string(forKey: userDefaultsKey).flatMap(Value.init(rawValue:)) ?? defaultValue
    }

    static func set(_ value: Value, to store: UserDefaults) {
        store.set(value.rawValue, forKey: userDefaultsKey)
    }
}
