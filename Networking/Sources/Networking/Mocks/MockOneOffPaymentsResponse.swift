//
//  MockOneOffPaymentsResponse.swift
//  API
//
//  Created by Raivis on 28/7/25.
//

public extension OneOffPaymentResponse {
  static func mock(moneybox: Double = 999.99) -> Self {
    .init(moneybox: moneybox)
  }
}
