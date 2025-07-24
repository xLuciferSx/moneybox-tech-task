//
//  LoginViewModel.swift
//  MoneyBox
//
//  Created by Raivis on 24/7/25.
//
//

import Foundation
import SwiftUI

@MainActor
final class LoginViewModel: ObservableObject {
  @Published var email = ""
  @Published var password = ""
  @Published private(set) var isLoading = false
  @Published private(set) var errorMessage: String?


  func login() async {
    guard !email.isEmpty, !password.isEmpty else {
      errorMessage = "Email & password required."
      return
    }
    isLoading = true
    defer { isLoading = false }
    do {
      //Implementing login
    } catch {
      errorMessage = error.localizedDescription
    }
  }

  func clearError() {
    errorMessage = nil
  }
}
