//
//  KeychainManager.swift
//  MoneyBox
//
//  Created by Raivis on 24/7/25.
//

import Combine
import Foundation
import KeychainSwift
import Networking

protocol TokenStore: ObservableObject {
  var token: String? { get }
  var user: LoginResponse.User? { get }
  func save(response: LoginResponse) throws
  func retrieve() throws -> String?
  func clear() throws
}

final class KeychainManager: ObservableObject, TokenStore {
  static let shared = KeychainManager()

  @Published private(set) var token: String?
  @Published private(set) var user: LoginResponse.User?

  private let keychain = KeychainSwift()
  private let key = "authToken"

  private init() {
    let stored = keychain.get(key)
    token = stored
    Authentication.token = stored
  }

  func save(response: LoginResponse) throws {
    let newToken = response.session.bearerToken
    guard keychain.set(newToken, forKey: key, withAccess: .accessibleAfterFirstUnlock) else {
      throw NSError(domain: "KeychainError", code: 1)
    }
    DispatchQueue.main.async {
      self.token = newToken
      self.user = response.user
      Authentication.token = newToken
    }
  }

  func retrieve() throws -> String? {
    keychain.get(key)
  }

  func clear() throws {
    keychain.delete(key)
    DispatchQueue.main.async {
      self.token = nil
      self.user = nil
      Authentication.token = nil
    }
  }
}
