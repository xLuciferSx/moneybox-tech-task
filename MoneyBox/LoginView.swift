//
//  LoginView.swift
//  MoneyBox
//
//  Created by Raivis on 24/7/25.
//

import SwiftUI

struct LoginView: View {
  @State private var email = ""
  @State private var password = ""

  var body: some View {
    VStack(spacing: 16) {
      TextField("Email", text: $email)
        .textFieldStyle(.roundedBorder)
        .keyboardType(.emailAddress)
        .autocapitalization(.none)

      SecureField("Password", text: $password)
        .textFieldStyle(.roundedBorder)

      Button("Log In") {
        // Implementing functionality here. :)
      }
      .buttonStyle(.borderedProminent)

      Spacer()
    }
    .padding()
    .navigationTitle("Login")
  }
}
