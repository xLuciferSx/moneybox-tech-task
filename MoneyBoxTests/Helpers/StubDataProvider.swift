//
//  StubDataProvider.swift
//  MoneyBox
//
//  Created by Raivis on 27/7/25.
//

import Foundation
import Networking

final class StubDataProvider: DataProviderLogic {
  var loginResult: Result<LoginResponse, Error> = .failure(NSError())
  var fetchProductsResult: Result<AccountResponse, Error> = .failure(NSError())
  var addMoneyResult: Result<OneOffPaymentResponse, Error> = .failure(NSError())

  func login(
    request: LoginRequest,
    completion: @escaping (Result<LoginResponse, Error>) -> Void
  ) {
    completion(loginResult)
  }

  func fetchProducts(
    completion: @escaping (Result<AccountResponse, Error>
    ) -> Void)
  {
    completion(fetchProductsResult)
  }

  func addMoney(
    request: OneOffPaymentRequest,
    completion: @escaping (
      Result<OneOffPaymentResponse, Error>
    ) -> Void
  ) {
    completion(addMoneyResult)
  }
}
