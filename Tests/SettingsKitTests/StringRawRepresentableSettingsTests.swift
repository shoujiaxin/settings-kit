//
//  StringRawRepresentableSettingsTests.swift
//  SettingsKitTests
//
//  Created by Jiaxin Shou on 2024/7/1.
//

import Foundation
@testable import SettingsKit
import Testing

private enum StringRawRepresentableSettings: String {
    case optionA

    case optionB
}

extension StringRawRepresentableSettings: PersistentSettings {
    typealias Value = Self

    static let defaultValue: StringRawRepresentableSettings = .optionA

    static let userDefaultsKey: String = "StringRawRepresentableSettingsKey"
}

@Suite
final class StringRawRepresentableSettingsTests {
    @SettingsStorage(StringRawRepresentableSettings.self, store: .standard)
    private var storage

    @Test
    func readAndWrite() async throws {
        UserDefaults.standard.removeObject(forKey: StringRawRepresentableSettings.userDefaultsKey)

        #expect(storage == .optionA)

        storage = .optionB

        #expect(storage == .optionB)
    }
}
