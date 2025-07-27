//
//  AccountCardView.swift
//  MoneyBox
//
//  Created by Raivis on 27/7/25.
//


import SwiftUI

struct AccountCardView: View {
    let title: String
    let planValue: Double
    let moneyboxPlanValue: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.headline)
            Text("Plan Value: £\(planValue, specifier: "%.0f")")
            Text("Moneybox: £\(moneyboxPlanValue, specifier: "%.0f")")
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}
