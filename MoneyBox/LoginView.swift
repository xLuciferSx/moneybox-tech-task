//
//  LoginView.swift
//  MoneyBox
//
//  Created by Raivis on 24/7/25.
//

import SwiftUI


struct LoginView: View {
    var body: some View {
        VStack(spacing: 16) {
          TextField("Email", text: .constant(""))
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: .constant(""))
                .textFieldStyle(.roundedBorder)
            
            Button("Log In") {
                Task {  }
            }
        }
        .padding()
        .navigationTitle("Login")
    }
}
