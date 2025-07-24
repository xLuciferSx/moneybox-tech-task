//
//  Container.swift
//  MoneyBox
//
//  Created by Raivis on 24/7/25.
//

import Factory
import Networking

extension Container {
  static let shared = Container()

  var dataProvider: Factory<DataProviderLogic> {
    Factory(self) { DataProvider() }
  }

  var keychainManager: Factory<any TokenStore> {
    Factory(self) { KeychainManager.shared }
  }
  
  var accountManager: Factory<AccountManagerProtocol> {
    Factory(self) { AccountManager() }
  }

  var loginManager: Factory<LoginManager> {
    Factory(self) {
      LoginManager()
    }
  }
}
