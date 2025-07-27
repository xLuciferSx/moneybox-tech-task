//
//  LoginManagerTests.swift
//  MoneyBox
//
//  Created by Raivis on 27/7/25.
//

import Factory
import Foundation
@testable import MoneyBox
import Networking
import Testing

class LoginManagerTests {
  private var stubDP: StubDataProvider!
  private var stubKC: StubKeychain!

  init() {
    stubDP = .init()
    stubKC = .init()

    Container.shared.dataProvider.register { self.stubDP }
    Container.shared.keychainManager.register { self.stubKC }
  }

  @Test("Login User Succesfully and save their bearer token")
  func login_success_savesTokenAndUser() async throws {
    // Given
    let bundle = Bundle(for: type(of: self))
    let url = bundle.url(forResource: "LoginSucceed", withExtension: "json")!
    let data = try Data(contentsOf: url)
    let resp = try JSONDecoder().decode(LoginResponse.self, from: data)

    stubDP.loginResult = .success(resp)

    var sut = LoginManager()
    sut.dataProvider = stubDP
    sut.keychainManager = stubKC
    
    // When
    let out = try await sut.login(email: "test+ios@moneyboxapp.com", password: "password")

    // Then
    #expect(out.session.bearerToken == resp.session.bearerToken)
    #expect(out.user.firstName == resp.user.firstName)

    #expect(stubKC.savedToken == resp.session.bearerToken)
    #expect(stubKC.savedUser?.lastName == resp.user.lastName)

    #expect(sut.currentToken == resp.session.bearerToken)
    #expect(sut.currentUser?.email == resp.user.email)
  }

  @Test("Login failure throws and does not save")
  func test_login_failure_doesNotSaveAndThrows() async {
    let error = NSError(
      domain: "",
      code: 401,
      userInfo: [NSLocalizedDescriptionKey: "Invalid credentials"]
    )

    stubDP.loginResult = .failure(error)

    let sut = LoginManager()

    await #expect(throws: NSError.self) {
      try await sut.login(email: "bad", password: "creds")
    }

    #expect(stubKC.savedToken == nil)
    #expect(sut.currentUser == nil)
  }

  @Test("Logout clears keychain")
  func test_logout_clearsKeychain() {
    // Given
    var sut = LoginManager()
    sut.keychainManager = stubKC
    let mockUser = LoginResponse.mock().user
    stubKC.savedToken = "FAKE_BEARER_TOKEN"
    stubKC.savedUser = mockUser

    Container.shared.keychainManager.register { self.stubKC }

    #expect(sut.currentToken == "FAKE_BEARER_TOKEN")
    #expect(sut.currentUser?.email == "foo@bar.com")

    // When
    try? sut.logout()

    // Then
    #expect(stubKC.savedToken == nil)
    #expect(stubKC.savedUser == nil)
    #expect(sut.currentToken == nil)
    #expect(sut.currentUser == nil)
  }
}
