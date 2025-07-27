//
//  AccountsView.swift
//  MoneyBox
//
//  Created by Raivis on 24/7/25.
//

import Factory
import SwiftUI

struct AccountsView: View {
  @StateObject private var viewModel = AccountsViewModel()

  var body: some View {
    ZStack {
      if viewModel.isLoading {
        ProgressView()
          .scaleEffect(1.5)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .ignoresSafeArea()
      } else {
        mainContent
      }
    }
    .task { await viewModel.fetchAccountDetails() }
    .padding()
  }

  private var mainContent: some View {
    ScrollView(showsIndicators: false) {
      VStack(alignment: .leading, spacing: 16) {
        VStack(alignment: .leading, spacing: 8) {
          Text("user_accounts".localized)
            .font(.title2).bold()
          Text("hello".localized(viewModel.userName))
            .font(.title3)
          Text("total_plan_value".localized(viewModel.totalPlanValue))
            .font(.headline)
        }

        LazyVStack(alignment: .leading, spacing: 12) {
          ForEach(viewModel.products, id: \.id) { product in
            NavigationLink {
              ProductDetailsView(
                store: .init(initialState: .init(
                  product: product
                ), reducer: {
                  ProductDetailsLogic()
                }))
            } label: {
              AccountCardView(
                title: product.product?.friendlyName ?? "Unknown",
                planValue: product.planValue ?? 0,
                moneyboxPlanValue: product.moneybox ?? 0
              )
            }
            .buttonStyle(.plain)
          }
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .navigationTitle("accounts_title")
  }
}

#Preview {
  AccountsView()
}
