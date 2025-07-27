//
//  AccountsViewModel.swift
//  MoneyBox
//
//  Created by Raivis on 27/7/25.
//

import Factory
import Foundation
import Networking

@MainActor
final class AccountsViewModel: ObservableObject {
  @Injected(\.accountManager) var accountManager
  @Injected(\.keychainManager) var keychainManager
  
  @Published var userAccount: [AccountResponse] = []
  @Published var isLoading = false
  @Published var errorMessage: String?
  @Published var selectedProduct: ProductResponse?
  
  var products: [ProductResponse] {
    userAccount.first?.productResponses ?? []
  }

  func fetchAccountDetails() async {
    isLoading = true
    
    do {
      let response = try await accountManager.fetchProducts()
      userAccount = [response]
      isLoading = false
    } catch {
      isLoading = false
      errorMessage = error.localizedDescription
    }
  }
  
  var totalPlanValue: Double {
    //Need to rethink this one because value is wrong...
    userAccount
      .map { Double($0.totalPlanValue ?? 0) / 100.0 }
      .reduce(0, +)
  }
    
  var userName: String {
    let name = [keychainManager.user?.firstName, keychainManager.user?.lastName]
      .compactMap { $0?.trimmingCharacters(in: .whitespaces) }
      .joined(separator: " ")
    return name.isEmpty ? "User" : name
  }
}
