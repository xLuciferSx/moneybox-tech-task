//
//  ProductDetailsView.swift
//  MoneyBox
//
//  Created by Raivis on 27/7/25.
//

import Factory
import Networking
import ComposableArchitecture
import SwiftUI

struct ProductDetailsView: View {
  @Perception.Bindable public var store: StoreOf<ProductDetailsLogic>
  
  public init(
    store: StoreOf<ProductDetailsLogic>,
  ) {
    self.store = store
  }

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 24) {
        Text("Individual Account")
          .font(.title2).bold()

        VStack(alignment: .leading, spacing: 8) {
          Text(store.product?.product?.friendlyName
            ?? "Unknown")
            .font(.title3)
          Text("Plan Value: £\(store.product?.planValue ?? 0, specifier: "%.0f")")
          Text("Moneybox: £\(store.product?.moneybox ?? 0, specifier: "%.0f")")
        }

        Spacer()

        Button {
          // TODO: your “add £10” action
        } label: {
          Text("Add £10")
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
      }
      .padding()
    }
    .navigationTitle("Individual Account")
    .navigationBarTitleDisplayMode(.inline)
  }
}
