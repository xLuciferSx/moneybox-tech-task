//
//  String+Extension.swift
//  MoneyBox
//
//  Created by Raivis on 27/7/25.
//

import Foundation

extension String {
  var localized: String {
    NSLocalizedString(self, bundle: .main, comment: "")
  }

  var intValue: Int? {
    Int(self)
  }

  var digitsOnly: String { self.filter(\.isNumber) }

  func localized(_ args: CVarArg...) -> String {
    String(
      format: localized,
      locale: .current,
      arguments: args
    )
  }
}
