//
//  LoginManaging.swift
//  MoneyBox
//
//  Created by Raivis on 24/7/25.
//

import Factory
import Foundation
import Networking

protocol LoginManagerProtocol {
  func login(email: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) // Old way off handling login
  func login(email: String, password: String) async throws -> LoginResponse // async method
  func logout() throws

  var currentToken: String? { get }
  var currentUser: LoginResponse.User? { get }
}

struct LoginManager: LoginManagerProtocol {
  @Injected(\.dataProvider) var dataProvider
  @Injected(\.keychainManager) var keychainManager

  var currentToken: String? {
    try? keychainManager.retrieve()
  }

  var currentUser: LoginResponse.User? { keychainManager.user }

  func login(
    email: String,
    password: String,
    completion: @escaping (Result<LoginResponse, Error>) -> Void
  ) {
    let request = LoginRequest(email: email, password: password)
    dataProvider.login(request: request) { result in
      switch result {
      case .success(let resp):
        do {
          do {
            try keychainManager.save(response: resp)
            completion(.success(resp))
          } catch {
            completion(.failure(error))
          }
        }
      case .failure(let err):
        completion(.failure(err))
      }
    }
  }

  func login(email: String, password: String) async throws -> LoginResponse {
    try await withCheckedThrowingContinuation { cont in
      login(email: email, password: password) { result in
        cont.resume(with: result)
      }
    }
  }

  func logout() throws {
    try keychainManager.clear()
  }
}
