//
//  AccountsManagerTests.swift
//  MoneyBox
//
//  Created by Raivis on 28/7/25.
//


import Factory
import Foundation
@testable import MoneyBox
import Networking
import Testing

final class AccountsManagerTests {
  private var stubDP: StubDataProvider!
  private var stubKC: StubKeychain!

  init() {
    stubDP = .init()
    stubKC = .init()

    Container.shared.dataProvider.register { self.stubDP }
    Container.shared.keychainManager.register { self.stubKC }
  }

  @Test("fetchProducts returns success response")
  func test_fetchProducts_success() async throws {
    let bundle = Bundle(for: type(of: self))
    let url = bundle.url(forResource: "Accounts", withExtension: "json")!
    let data = try Data(contentsOf: url)
    let response = try JSONDecoder().decode(AccountResponse.self, from: data)

    stubDP.fetchProductsResult = .success(response)

    var sut = AccountManager()
    sut.dataProvider = stubDP
    
    let result = try await sut.fetchProducts()

    #expect(result.totalPlanValue == response.totalPlanValue)
    #expect(result.productResponses?.count == 2)
  }

  @Test("fetchProducts clears keychain if expired")
  func test_fetchProducts_failure_expired() async {
    stubDP.fetchProductsResult = .failure(NSError(
      domain: "", code: 401,
      userInfo: [NSLocalizedDescriptionKey: "token expired"]
    ))

    let sut = AccountManager()
    
    do {
      _ = try await sut.fetchProducts()
      #expect(Bool(false), "Expected error but got success")
    } catch {
      #expect(stubKC.savedToken == nil)
      #expect(stubKC.savedUser == nil)
    }
  }

  @Test("addMoney returns success")
  func test_addMoney_success() async throws {
    stubDP.addMoneyResult = .success(.mock())

    var sut = AccountManager()
    sut.keychainManager = stubKC
    sut.dataProvider = stubDP

    let response = try await sut.addMoney(amount: 100, to: 7)

    #expect(response.moneybox == 999.99)
  }

  @Test("addMoney clears keychain on expired token")
  func test_addMoney_failure_expired() async {
    stubDP.addMoneyResult = .failure(NSError(
      domain: "",
      code: 401,
      userInfo: [NSLocalizedDescriptionKey: "expired token"]
    ))

    let sut = AccountManager()

    do {
      _ = try await sut.addMoney(amount: 100, to: 7)
      #expect(Bool(false), "Expected error but got success")
    } catch {
      #expect(stubKC.savedToken == nil)
      #expect(stubKC.savedUser == nil)
    }
  }
}
