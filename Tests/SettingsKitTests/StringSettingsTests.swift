//
//  StringSettingsTests.swift
//  SettingsKitTests
//
//  Created by Jiaxin Shou on 2024/6/3.
//

import Foundation
@testable import SettingsKit
import Testing

private struct StringSettings: PersistentSettings {
    typealias Value = String

    static let defaultValue: String = "StringSettingsDefault"

    static let userDefaultsKey: String = "StringSettingsKey"
}

@Suite
final class StringSettingsTests {
    @SettingsStorage(StringSettings.self, store: .standard)
    private var storage

    @Test
    func readAndWrite() async throws {
        UserDefaults.standard.removeObject(forKey: StringSettings.userDefaultsKey)

        #expect(storage == StringSettings.defaultValue)

        storage = "StringSettingsNew"

        #expect(storage == "StringSettingsNew")
    }
}
