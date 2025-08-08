//
//  main.swift
//  SettingsKitClient
//
//  Created by Jiaxin Shou on 2024/7/1.
//

import Observation
import SettingsKit

struct ClientSettings: PersistentSettings {
    typealias Value = String

    static let defaultValue: Value = "default value"

    static let userDefaultsKey: String = "client settings key"
}

@available(iOS 17.0, *)
@available(macOS 14.0, *)
@Observable
final class ViewModel {
    @ObservableSettings(ClientSettings.self, store: .standard)
    @ObservationIgnored
    var settings: ClientSettings.Value
}
