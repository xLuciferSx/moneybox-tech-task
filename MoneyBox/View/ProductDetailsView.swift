//
//  ProductDetailsView.swift
//  MoneyBox
//
//  Created by Raivis on 27/7/25.
//

import Factory
import Networking
import SwiftUI

struct ProductDetailsView: View {
  let product: ProductResponse

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 24) {
        Text("Individual Account")
          .font(.title2).bold()

        VStack(alignment: .leading, spacing: 8) {
          Text(product.product?.friendlyName
            ?? product.product?.name
            ?? "Unknown")
            .font(.title3)
          Text("Plan Value: £\(product.planValue ?? 0, specifier: "%.0f")")
          Text("Moneybox: £\(product.moneybox ?? 0, specifier: "%.0f")")
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
