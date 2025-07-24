//
//  AccountsManager.swift
//  MoneyBox
//
//  Created by Raivis on 24/7/25.
//

import Factory
import Networking

protocol AccountsManagerProtocol {
  func fetchProducts(completion: @escaping (Result<AccountResponse, Error>) -> Void)
}

struct AccountManager: AccountsManagerProtocol {
  @Injected(\.dataProvider) var dataProvider

  func fetchProducts(completion: @escaping (Result<AccountResponse, Error>) -> Void) {
    dataProvider.fetchProducts { result in
      switch result {
        case .success(let resp): completion(.success(resp))
        case .failure(let err): completion(.failure(err))
      }
    }
  }
}
