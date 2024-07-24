//
//  ObservableSettings.swift
//  SettingsKit
//
//  Created by Jiaxin Shou on 2024/7/1.
//

import Foundation

@attached(accessor, names: named(get), named(set))
public macro ObservableSettings<T>(
    _ type: T.Type,
    store: UserDefaults
) = #externalMacro(
    module: "SettingsKitMacros",
    type: "ObservableSettingsMacro"
) where T: PersistentSettings
