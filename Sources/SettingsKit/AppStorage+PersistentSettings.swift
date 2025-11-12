//
//  AppStorage+PersistentSettings.swift
//  SettingsKit
//
//  Created by Jiaxin Shou on 2024/6/3.
//

import SwiftUI

/// Extension providing convenient initializers for `AppStorage` using `PersistentSettings`.
///
/// These initializers allow you to use `PersistentSettings` types with SwiftUI's
/// `@AppStorage` property wrapper, providing type-safe access to UserDefaults
/// with automatic view updates when values change.
public extension AppStorage {
    /// Creates an AppStorage instance for a String-valued setting.
    ///
    /// Use this initializer to create a SwiftUI `@AppStorage` property that
    /// automatically reads from and writes to UserDefaults using a
    /// `PersistentSettings` configuration.
    ///
    /// ## Example
    ///
    /// ```swift
    /// struct UserNameSetting: PersistentSettings {
    ///     typealias Value = String
    ///     static let defaultValue = "Anonymous"
    ///     static let userDefaultsKey = "userName"
    /// }
    ///
    /// struct SettingsView: View {
    ///     @AppStorage(UserNameSetting.self) var userName
    ///
    ///     var body: some View {
    ///         TextField("Name", text: $userName)
    ///     }
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - type: The `PersistentSettings` type that defines the setting configuration.
    ///   - store: The UserDefaults instance to use. Defaults to `.standard` if not specified.
    init(
        _ type: (some PersistentSettings<Value>).Type,
        store: UserDefaults? = nil
    ) where Value == String {
        self.init(
            wrappedValue: type.defaultValue,
            type.userDefaultsKey,
            store: store
        )
    }

    /// Creates an AppStorage instance for a RawRepresentable setting with Int raw values.
    ///
    /// Use this initializer for enum or other RawRepresentable types that use Int
    /// as their raw value, enabling seamless storage in UserDefaults.
    ///
    /// - Parameters:
    ///   - type: The `PersistentSettings` type that defines the setting configuration.
    ///   - store: The UserDefaults instance to use. Defaults to `.standard` if not specified.
    init(
        _ type: (some PersistentSettings<Value>).Type,
        store: UserDefaults? = nil
    ) where Value: RawRepresentable, Value.RawValue == Int {
        self.init(
            wrappedValue: type.defaultValue,
            type.userDefaultsKey,
            store: store
        )
    }

    /// Creates an AppStorage instance for a Data-valued setting.
    ///
    /// Use this initializer to store binary data in UserDefaults through SwiftUI's
    /// `@AppStorage` property wrapper.
    ///
    /// - Parameters:
    ///   - type: The `PersistentSettings` type that defines the setting configuration.
    ///   - store: The UserDefaults instance to use. Defaults to `.standard` if not specified.
    init(
        _ type: (some PersistentSettings<Value>).Type,
        store: UserDefaults? = nil
    ) where Value == Data {
        self.init(
            wrappedValue: type.defaultValue,
            type.userDefaultsKey,
            store: store
        )
    }

    /// Creates an AppStorage instance for an Int-valued setting.
    ///
    /// Use this initializer to store integer values in UserDefaults through SwiftUI's
    /// `@AppStorage` property wrapper.
    ///
    /// - Parameters:
    ///   - type: The `PersistentSettings` type that defines the setting configuration.
    ///   - store: The UserDefaults instance to use. Defaults to `.standard` if not specified.
    init(
        _ type: (some PersistentSettings<Value>).Type,
        store: UserDefaults? = nil
    ) where Value == Int {
        self.init(
            wrappedValue: type.defaultValue,
            type.userDefaultsKey,
            store: store
        )
    }

    /// Creates an AppStorage instance for a RawRepresentable setting with String raw values.
    ///
    /// Use this initializer for enum or other RawRepresentable types that use String
    /// as their raw value, enabling seamless storage in UserDefaults.
    ///
    /// - Parameters:
    ///   - type: The `PersistentSettings` type that defines the setting configuration.
    ///   - store: The UserDefaults instance to use. Defaults to `.standard` if not specified.
    init(
        _ type: (some PersistentSettings<Value>).Type,
        store: UserDefaults? = nil
    ) where Value: RawRepresentable, Value.RawValue == String {
        self.init(
            wrappedValue: type.defaultValue,
            type.userDefaultsKey,
            store: store
        )
    }

    /// Creates an AppStorage instance for a URL-valued setting.
    ///
    /// Use this initializer to store URL values in UserDefaults through SwiftUI's
    /// `@AppStorage` property wrapper.
    ///
    /// - Parameters:
    ///   - type: The `PersistentSettings` type that defines the setting configuration.
    ///   - store: The UserDefaults instance to use. Defaults to `.standard` if not specified.
    init(
        _ type: (some PersistentSettings<Value>).Type,
        store: UserDefaults? = nil
    ) where Value == URL {
        self.init(
            wrappedValue: type.defaultValue,
            type.userDefaultsKey,
            store: store
        )
    }

    /// Creates an AppStorage instance for a Double-valued setting.
    ///
    /// Use this initializer to store double-precision floating-point values in
    /// UserDefaults through SwiftUI's `@AppStorage` property wrapper.
    ///
    /// - Parameters:
    ///   - type: The `PersistentSettings` type that defines the setting configuration.
    ///   - store: The UserDefaults instance to use. Defaults to `.standard` if not specified.
    init(
        _ type: (some PersistentSettings<Value>).Type,
        store: UserDefaults? = nil
    ) where Value == Double {
        self.init(
            wrappedValue: type.defaultValue,
            type.userDefaultsKey,
            store: store
        )
    }

    /// Creates an AppStorage instance for a Bool-valued setting.
    ///
    /// Use this initializer to store boolean values in UserDefaults through SwiftUI's
    /// `@AppStorage` property wrapper.
    ///
    /// - Parameters:
    ///   - type: The `PersistentSettings` type that defines the setting configuration.
    ///   - store: The UserDefaults instance to use. Defaults to `.standard` if not specified.
    init(
        _ type: (some PersistentSettings<Value>).Type,
        store: UserDefaults? = nil
    ) where Value == Bool {
        self.init(
            wrappedValue: type.defaultValue,
            type.userDefaultsKey,
            store: store
        )
    }
}
