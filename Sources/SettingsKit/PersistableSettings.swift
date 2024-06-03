//
//  PersistableSettings.swift
//  SettingsKit
//
//  Created by Jiaxin Shou on 2024/6/3.
//

import Foundation

// MARK: - Interfaces

public protocol PersistableSettings<Value> {
    associatedtype Value

    static var defaultValue: Value { get }

    static var userDefaultsKey: String { get }

    static func value(in store: UserDefaults) -> Value
}

// MARK: - Default Implementations

public extension PersistableSettings where Value == URL {
    static func value(in store: UserDefaults) -> Value {
        store.url(forKey: userDefaultsKey) ?? defaultValue
    }
}

public extension PersistableSettings where Value == String {
    static func value(in store: UserDefaults) -> Value {
        store.string(forKey: userDefaultsKey) ?? defaultValue
    }
}

public extension PersistableSettings where Value == Data {
    static func value(in store: UserDefaults) -> Value {
        store.data(forKey: userDefaultsKey) ?? defaultValue
    }
}

public extension PersistableSettings where Value == Bool {
    static func value(in store: UserDefaults) -> Value {
        store.bool(forKey: userDefaultsKey)
    }
}

public extension PersistableSettings where Value == Int {
    static func value(in store: UserDefaults) -> Value {
        store.integer(forKey: userDefaultsKey)
    }
}

public extension PersistableSettings where Value == Float {
    static func value(in store: UserDefaults) -> Value {
        store.float(forKey: userDefaultsKey)
    }
}

public extension PersistableSettings where Value == Double {
    static func value(in store: UserDefaults) -> Value {
        store.double(forKey: userDefaultsKey)
    }
}

public extension PersistableSettings where Value: RawRepresentable, Value.RawValue == Int {
    static func value(in store: UserDefaults) -> Value {
        Value(rawValue: store.integer(forKey: userDefaultsKey)) ?? defaultValue
    }
}

public extension PersistableSettings where Value: RawRepresentable, Value.RawValue == String {
    static func value(in store: UserDefaults) -> Value {
        store.string(forKey: userDefaultsKey).flatMap(Value.init(rawValue:)) ?? defaultValue
    }
}
