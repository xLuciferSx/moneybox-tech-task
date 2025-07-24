//
//  MoneyBoxApp.swift
//  MoneyBox
//
//  Created by Raivis on 24/7/25.
//

import SwiftUI

@main
struct MoneyBoxApp: App {
  var body: some Scene {
    WindowGroup {
      NavigationView {
        LoginView()
      }
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}
