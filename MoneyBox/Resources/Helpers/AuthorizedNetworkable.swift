//
//  AuthorizedNetworkable.swift
//  MoneyBox
//
//  Created by Raivis on 27/7/25.
//

import Foundation
import Networking

struct AuthorizedNetworkable<Base: AppNetworkable>: AppNetworkable {
  let base: Base

  var request: URLRequest {
    var req = base.request
    if let token = KeychainManager.shared.token {
      req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    }
    return req
  }
}
