//
//  AccountsView.swift
//  MoneyBox
//
//  Created by Raivis on 24/7/25.
//

import SwiftUI
import Factory

struct AccountsView: View {
  @Injected(\.loginManager) var loginManager
  
  var body: some View {
    Button {
      try? loginManager.logout()
    } label: {
      Text("Logout")
    }

  }
}

#Preview {
  AccountsView()
}
