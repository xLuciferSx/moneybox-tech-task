//
//  KeychainManager.swift
//  MoneyBox
//
//  Created by Raivis on 24/7/25.
//

import Foundation
import KeychainSwift

protocol TokenStore {
    func save(_ token: String) throws
    func retrieve() throws -> String?
    func clear() throws
}

struct KeychainManager: TokenStore {
    private let keychain = KeychainSwift()
    private let key = "authToken"

    func save(_ token: String) throws {
        guard keychain.set(token, forKey: key, withAccess: .accessibleAfterFirstUnlock) else {
            throw NSError(domain: "KeychainError", code: 1)
        }
    }

    func retrieve() throws -> String? {
        keychain.get(key)
    }

    func clear() throws {
        keychain.delete(key)
    }
}
