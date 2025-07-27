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
            Text("plan_value".localized(store.product?.planValue ?? 0))
            Text("moneybox_value".localized(store.product?.moneybox ?? 0))
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
          .keyboardType(.numberPad)
          .textFieldStyle(.roundedBorder)

          Button {
            store.send(.addMoney)
          } label: {
            WithPerceptionTracking {
              Group {
                if store.isLoading {
                  ProgressView()
                } else {
                  Text("add_button".localized(store.amountString))
                }
              }
              .frame(maxWidth: .infinity)
            }
          }
          .buttonStyle(.borderedProminent)
          .disabled(store.amountString.isEmpty || store.isLoading)
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
