//
//  LoginManagerTests.swift
//  MoneyBox
//
//  Created by Raivis on 27/7/25.
//

import Testing
import Foundation
import Networking
import Factory
@testable import MoneyBox

@MainActor
class LoginManagerTests {
  var sut: LoginManager!
  
  init() {}
  
  @Test("Testing Login 1")
  func test_login_success() async throws {
    let login = "1"
    #expect(login == "1")
  }
}

