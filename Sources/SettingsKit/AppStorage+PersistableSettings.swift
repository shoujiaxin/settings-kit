//
//  AppStorage+PersistableSettings.swift
//  SettingsKit
//
//  Created by Jiaxin Shou on 2024/6/3.
//

import SwiftUI

public extension AppStorage {
    init(
        _ type: (some PersistableSettings<Value>).Type,
        store: UserDefaults? = nil
    ) where Value == String {
        self.init(
            wrappedValue: type.defaultValue,
            type.userDefaultsKey,
            store: store
        )
    }

    init(
        _ type: (some PersistableSettings<Value>).Type,
        store: UserDefaults? = nil
    ) where Value: RawRepresentable, Value.RawValue == Int {
        self.init(
            wrappedValue: type.defaultValue,
            type.userDefaultsKey,
            store: store
        )
    }

    init(
        _ type: (some PersistableSettings<Value>).Type,
        store: UserDefaults? = nil
    ) where Value == Data {
        self.init(
            wrappedValue: type.defaultValue,
            type.userDefaultsKey,
            store: store
        )
    }

    init(
        _ type: (some PersistableSettings<Value>).Type,
        store: UserDefaults? = nil
    ) where Value == Int {
        self.init(
            wrappedValue: type.defaultValue,
            type.userDefaultsKey,
            store: store
        )
    }

    init(
        _ type: (some PersistableSettings<Value>).Type,
        store: UserDefaults? = nil
    ) where Value: RawRepresentable, Value.RawValue == String {
        self.init(
            wrappedValue: type.defaultValue,
            type.userDefaultsKey,
            store: store
        )
    }

    init(
        _ type: (some PersistableSettings<Value>).Type,
        store: UserDefaults? = nil
    ) where Value == URL {
        self.init(
            wrappedValue: type.defaultValue,
            type.userDefaultsKey,
            store: store
        )
    }

    init(
        _ type: (some PersistableSettings<Value>).Type,
        store: UserDefaults? = nil
    ) where Value == Double {
        self.init(
            wrappedValue: type.defaultValue,
            type.userDefaultsKey,
            store: store
        )
    }

    init(
        _ type: (some PersistableSettings<Value>).Type,
        store: UserDefaults? = nil
    ) where Value == Bool {
        self.init(
            wrappedValue: type.defaultValue,
            type.userDefaultsKey,
            store: store
        )
    }
}
