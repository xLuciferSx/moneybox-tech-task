//
//  ProductDetailsView.swift
//  MoneyBox
//
//  Created by Raivis on 27/7/25.
//

import ComposableArchitecture
import Factory
import Networking
import SwiftUI

struct ProductDetailsView: View {
  @Perception.Bindable public var store: StoreOf<ProductDetailsLogic>
  @Environment(\.dismiss) var dismiss

  public init(
    store: StoreOf<ProductDetailsLogic>,
  ) {
    self.store = store
  }

  var body: some View {
    ScrollView {
      WithPerceptionTracking {
        VStack(alignment: .leading, spacing: 24) {
          VStack(alignment: .leading, spacing: 8) {
            Text(store.product?.product?.friendlyName
              ?? "unknown".localized)
              .font(.title3)
              .accessibilityLabel("Product name")
              .accessibilityValue(store.product?.product?.friendlyName ?? "Unknown")
              .accessibilityIdentifier("product_title")

            Text("plan_value".localized(store.product?.planValue ?? 0))
              .accessibilityLabel("Plan value")
              .accessibilityValue("\(store.product?.planValue ?? 0)")
              .accessibilityIdentifier("plan_value")

            Text("moneybox_value".localized(store.product?.moneybox ?? 0))
              .accessibilityLabel("Moneybox value")
              .accessibilityValue("\(store.product?.moneybox ?? 0)")
              .accessibilityIdentifier("moneybox_value")
          }

          Spacer()

          TextField(
            "amount".localized,
            text: Binding(
              get: { store.amountString },
              set: { raw in
                let filtered = raw.digitsOnly
                store.send(.binding(.set(\.amountString, filtered)))
              }
            )
          )
          .accessibilityLabel("Amount to add")
          .accessibilityIdentifier("amount_text_field")
          .keyboardType(.numberPad)
          .textFieldStyle(.roundedBorder)

          Button {
            store.send(.addMoney)
          } label: {
            WithPerceptionTracking {
              Group {
                if store.isLoading {
                  ProgressView()
                    .accessibilityLabel("Loading")
                } else {
                  Text("add_button".localized(store.amountString))
                }
              }
              .frame(maxWidth: .infinity)
            }
          }
          .buttonStyle(.borderedProminent)
          .disabled(store.amountString.isEmpty || store.isLoading)
          .accessibilityLabel("Add money button")
          .accessibilityIdentifier("add_button")
        }
        .padding()
      }
    }
    .alert(isPresented: $store.showAlert) {
      Alert(
        title: Text(store.alertMessage ?? ""),
        dismissButton: .default(Text("ok".localized)) {
          if store.didAddMoneySuccessfully {
            dismiss()
          } else {
            store.send(.dismissAlert)
          }
        }
      )
    }
    .navigationTitle("individual_account_title".localized)
    .navigationBarTitleDisplayMode(.inline)
  }
}
