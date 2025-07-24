//
//  KeychainManager.swift
//  MoneyBox
//
//  Created by Raivis on 24/7/25.
//

import Combine
import Foundation
import KeychainSwift

protocol TokenStore: ObservableObject {
  func save(_ token: String) throws
  func retrieve() throws -> String?
  func clear() throws

  var token: String? { get }
}

final class KeychainManager: ObservableObject, TokenStore {
  static let shared = KeychainManager()

  @Published private(set) var token: String?

  private let keychain = KeychainSwift()
  private let key = "authToken"

  private init() {
    token = keychain.get(key)
  }

  func save(_ token: String) throws {
    guard keychain.set(token, forKey: key, withAccess: .accessibleAfterFirstUnlock)
    else { throw NSError(domain: "KeychainError", code: 1) }
    self.token = token
  }

  func retrieve() throws -> String? {
    keychain.get(key)
  }

  func clear() throws {
    keychain.delete(key)
    token = nil
  }
}
