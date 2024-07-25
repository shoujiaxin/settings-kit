//
//  PersistentSettings.swift
//  SettingsKit
//
//  Created by Jiaxin Shou on 2024/6/3.
//

import Foundation

// MARK: - Interfaces

public protocol PersistentSettings<Value>: Sendable where Value: Sendable {
    associatedtype Value

    static var defaultValue: Value { get }

    static var userDefaultsKey: String { get }

    static func value(in store: UserDefaults) -> Value

    static func set(_ value: Value, to store: UserDefaults)
}

// MARK: - Default Implementations

public extension PersistentSettings where Value == URL {
    static func value(in store: UserDefaults) -> Value {
        store.url(forKey: userDefaultsKey) ?? defaultValue
    }

    static func set(_ value: Value, to store: UserDefaults) {
        store.set(value, forKey: userDefaultsKey)
    }
}

public extension PersistentSettings where Value == String {
    static func value(in store: UserDefaults) -> Value {
        store.string(forKey: userDefaultsKey) ?? defaultValue
    }

    static func set(_ value: Value, to store: UserDefaults) {
        store.set(value, forKey: userDefaultsKey)
    }
}

public extension PersistentSettings where Value == Data {
    static func value(in store: UserDefaults) -> Value {
        store.data(forKey: userDefaultsKey) ?? defaultValue
    }

    static func set(_ value: Value, to store: UserDefaults) {
        store.set(value, forKey: userDefaultsKey)
    }
}

public extension PersistentSettings where Value == Bool {
    static func value(in store: UserDefaults) -> Value {
        store.bool(forKey: userDefaultsKey)
    }

    static func set(_ value: Value, to store: UserDefaults) {
        store.set(value, forKey: userDefaultsKey)
    }
}

public extension PersistentSettings where Value == Int {
    static func value(in store: UserDefaults) -> Value {
        store.integer(forKey: userDefaultsKey)
    }

    static func set(_ value: Value, to store: UserDefaults) {
        store.set(value, forKey: userDefaultsKey)
    }
}

public extension PersistentSettings where Value == Float {
    static func value(in store: UserDefaults) -> Value {
        store.float(forKey: userDefaultsKey)
    }

    static func set(_ value: Value, to store: UserDefaults) {
        store.set(value, forKey: userDefaultsKey)
    }
}

public extension PersistentSettings where Value == Double {
    static func value(in store: UserDefaults) -> Value {
        store.double(forKey: userDefaultsKey)
    }

    static func set(_ value: Value, to store: UserDefaults) {
        store.set(value, forKey: userDefaultsKey)
    }
}

public extension PersistentSettings where Value: RawRepresentable, Value.RawValue == Int {
    static func value(in store: UserDefaults) -> Value {
        Value(rawValue: store.integer(forKey: userDefaultsKey)) ?? defaultValue
    }

    static func set(_ value: Value, to store: UserDefaults) {
        store.set(value.rawValue, forKey: userDefaultsKey)
    }
}

public extension PersistentSettings where Value: RawRepresentable, Value.RawValue == String {
    static func value(in store: UserDefaults) -> Value {
        store.string(forKey: userDefaultsKey).flatMap(Value.init(rawValue:)) ?? defaultValue
    }

    static func set(_ value: Value, to store: UserDefaults) {
        store.set(value.rawValue, forKey: userDefaultsKey)
    }
}
