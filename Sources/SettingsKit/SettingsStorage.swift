//
//  SettingsStorage.swift
//  SettingsKit
//
//  Created by Jiaxin Shou on 2024/6/3.
//

import Foundation

@frozen
@propertyWrapper
public struct SettingsStorage<T, V> where T: PersistentSettings, T.Value == V {
    public var wrappedValue: V {
        get {
            type.value(in: store)
        }
        set {
            type.set(newValue, to: store)
        }
    }

    private let type: T.Type

    /// The user defaults store to read and write to.
    /// The `UserDefaults` class is thread-safe, so it's safe to be marked as `nonisolated(unsafe)`.
    private nonisolated(unsafe) let store: UserDefaults

    public init(_ type: T.Type, store: UserDefaults? = nil) {
        self.type = type
        self.store = store ?? .standard
    }
}

extension SettingsStorage: Sendable where V: Sendable {}
