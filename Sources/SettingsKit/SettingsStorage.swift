//
//  SettingsStorage.swift
//  SettingsKit
//
//  Created by Jiaxin Shou on 2024/6/3.
//

import Foundation

@frozen
@propertyWrapper
public struct SettingsStorage<T> where T: PersistentSettings {
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

    public init(_: T.Type, store: UserDefaults? = nil) {
        self.store = store ?? .standard
    }
}

extension SettingsStorage: Sendable where T.Value: Sendable {}
