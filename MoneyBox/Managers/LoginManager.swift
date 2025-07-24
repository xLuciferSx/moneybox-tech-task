//
//  LoginManaging.swift
//  MoneyBox
//
//  Created by Raivis on 24/7/25.
//

import Foundation
import Networking

protocol LoginManagerProtocol {
  func login(
    email: String,
    password: String,
    completion: @escaping (Result<LoginResponse, Error>) -> Void
  )

  func logout() throws
  var currentToken: String? { get }
}

struct LoginManager: LoginManagerProtocol {
  private let provider: DataProviderLogic
  private let tokenStore: TokenStore

  init(
    provider: DataProviderLogic = DataProvider(),
    tokenStore: TokenStore = KeychainManager()
  ) {
    self.provider = provider
    self.tokenStore = tokenStore
  }

  var currentToken: String? {
    try? tokenStore.retrieve()
  }

  func login(
    email: String,
    password: String,
    completion: @escaping (Result<LoginResponse, Error>) -> Void
  ) {
    let req = LoginRequest(email: email, password: password)
    provider.login(request: req) { result in
      switch result {
      case .success(let resp):
        do {
          try tokenStore.save(resp.session.bearerToken)
          completion(.success(resp))
        } catch {
          completion(.failure(error))
        }
      case .failure(let err):
        completion(.failure(err))
      }
    }
  }

  func logout() throws {
    try tokenStore.clear()
  }
}
