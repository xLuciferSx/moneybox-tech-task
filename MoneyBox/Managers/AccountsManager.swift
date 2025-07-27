//
//  AccountsManager.swift
//  MoneyBox
//
//  Created by Raivis on 24/7/25.
//

import Factory
import Networking

protocol AccountManagerProtocol {
  func fetchProducts() async throws -> AccountResponse
}

struct AccountManager: AccountManagerProtocol {
  @Injected(\.dataProvider) var dataProvider
  @Injected(\.keychainManager) var keychainManager

  func fetchProducts() async throws -> AccountResponse {
    do {
      return try await dataProvider.fetchProducts()
    } catch {
      if error.localizedDescription.lowercased().contains("expired") { //No status code and i have to relly on text....
        try? keychainManager.clear()
      }
      throw error
    }
  }
}
