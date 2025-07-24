//
//  MoneyBoxApp.swift
//  MoneyBox
//
//  Created by Raivis on 24/7/25.
//

import Factory
import SwiftUI

@main
struct MoneyBoxApp: App {
  @StateObject private var keychain = KeychainManager.shared

  var body: some Scene {
    WindowGroup {
      NavigationView {
        if keychain.token != nil {
          AccountsView()
        } else {
          LoginView()
        }
      }
      .environmentObject(keychain)
    }
  }
}
