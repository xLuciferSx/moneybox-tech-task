//
//  LoginView.swift
//  MoneyBox
//
//  Created by Raivis on 24/7/25.
//

import SwiftUI

struct LoginView: View {
  @StateObject private var viewModel = LoginViewModel()

  var body: some View {
    VStack(spacing: 16) {
      TextField("email".localized, text: $viewModel.email)
        .textFieldStyle(.roundedBorder)
        .keyboardType(.emailAddress)
        .autocapitalization(.none)

      SecureField("password".localized, text: $viewModel.password)
        .textFieldStyle(.roundedBorder)

      Button {
        Task { await viewModel.login() }
      } label: {
        if viewModel.isLoading {
          ProgressView()
        } else {
          Text("login".localized)
            .frame(maxWidth: .infinity)
        }
      }
      .buttonStyle(.borderedProminent)
      .disabled(viewModel.isLoading)

      Spacer()
    }
    .padding()
    .navigationTitle("login".localized)
    .alert(
      viewModel.errorMessage ?? "",
      isPresented: $viewModel.showingAlert)
    {
      Button("ok".localized) { viewModel.clearError() }
    }
  }
}
