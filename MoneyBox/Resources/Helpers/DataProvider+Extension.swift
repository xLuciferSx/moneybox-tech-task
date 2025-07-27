//
//  DataProvider+Extension.swift
//  MoneyBox
//
//  Created by Raivis on 27/7/25.
//

import Foundation
import SwiftUI
import Networking

extension DataProviderLogic {
    public func fetchProducts() async throws -> AccountResponse {
        try await withCheckedThrowingContinuation { continuation in
            fetchProducts { result in
                continuation.resume(with: result)
            }
        }
    }
    
    public func addMoney(request: OneOffPaymentRequest) async throws -> OneOffPaymentResponse {
        try await withCheckedThrowingContinuation { continuation in
            addMoney(request: request) { result in
                continuation.resume(with: result)
            }
        }
    }
}
