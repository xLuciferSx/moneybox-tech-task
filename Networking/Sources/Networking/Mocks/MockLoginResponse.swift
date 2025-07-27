//
//  MockLoginResponse.swift
//  API
//
//  Created by Raivis on 28/7/25.
//

public extension LoginResponse {
  static func mock(
    token: String = "FAKE_BEARER_TOKEN",
    firstName: String = "Foo",
    lastName: String = "Bar",
    email: String = "foo@bar.com"
  ) -> LoginResponse {
    LoginResponse(
      session: .init(bearerToken: token),
      user: .init(
        firstName: firstName,
        lastName: lastName,
        email: email
      )
    )
  }
}
