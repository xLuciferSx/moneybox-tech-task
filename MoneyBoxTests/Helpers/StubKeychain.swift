//
//  StubKeychain.swift
//  MoneyBox
//
//  Created by Raivis on 27/7/25.
//

import Networking
import Foundation

final class StubKeychain: TokenStore {
  var savedToken: String?
  var savedUser: LoginResponse.User?

  func save(response: LoginResponse) throws {
    savedToken = response.session.bearerToken
    savedUser = response.user
  }
  func retrieve() throws -> String? {
    savedToken
  }
  func clear() throws {
    savedToken = nil
    savedUser = nil
  }

  var token: String? { savedToken }
  var user: LoginResponse.User? { savedUser }
}
