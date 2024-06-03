//
//  SettingsStorage.swift
//  SettingsKit
//
//  Created by Jiaxin Shou on 2024/6/3.
//

import Foundation

@propertyWrapper
public struct SettingsStorage<T, V> where T: PersistableSettings, T.Value == V {
    public var wrappedValue: V {
        get {
            store.map(type.value(in:)) ?? type.defaultValue
        }
        set {
            store?.set(newValue, forKey: type.userDefaultsKey)
        }
    }

    private let type: T.Type

    private let store: UserDefaults?

    public init(_ type: T.Type, store: UserDefaults?) {
        self.type = type
        self.store = store
    }
}
