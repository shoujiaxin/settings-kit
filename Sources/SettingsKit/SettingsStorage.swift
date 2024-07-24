//
//  SettingsStorage.swift
//  SettingsKit
//
//  Created by Jiaxin Shou on 2024/6/3.
//

import Foundation

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

    private let store: UserDefaults

    public init(_ type: T.Type, store: UserDefaults) {
        self.type = type
        self.store = store
    }
}
