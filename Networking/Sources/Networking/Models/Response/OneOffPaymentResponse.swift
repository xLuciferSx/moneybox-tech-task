//
//  OneOffPaymentResponse.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 18.01.2022.
//

import Foundation

public struct OneOffPaymentResponse: Decodable, Equatable, Sendable {
    public let moneybox: Double?
    
    enum CodingKeys: String, CodingKey {
        case moneybox = "Moneybox"
    }
}
