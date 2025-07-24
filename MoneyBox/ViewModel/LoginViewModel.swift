//
//  LoginViewModel.swift
//  MoneyBox
//
//  Created by Raivis on 24/7/25.
//
//

import Factory
import Foundation
import SwiftUI

@MainActor
final class LoginViewModel: ObservableObject {
  @Injected(\.loginManager) var loginManager
  @Published var email = ""
  @Published var password = ""
  @Published private(set) var isLoading = false
  @Published private(set) var errorMessage: String?
  @Published var showingAlert = false

  func login() async {
    errorMessage = nil

    if email.isEmpty {
      errorMessage = "Please enter your email."
      showingAlert = true
      return
    }
    if password.isEmpty {
      errorMessage = "Please enter your password."
      showingAlert = true
      return
    }

    isLoading = true
    defer { isLoading = false }

    do {
      _ = try await loginManager.login(email: email, password: password)
    } catch {
      errorMessage = error.localizedDescription
      showingAlert = true
    }
  }

  func clearError() {
    errorMessage = nil
  }
}
