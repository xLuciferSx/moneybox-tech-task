//
//  LoginRequest.swift
//  MoneyBox
//
//  Created by Zeynep Kara on 16.01.2022.
//

import UIKit

// MARK: - LoginRequest
public struct LoginRequest: Encodable {
    public let email: String
    public let password: String
    let idfa: String = "ANYTHING"
    let uniqueDeviceId = UIDevice.current.identifierForVendor?.uuidString ?? ""
    let deviceId = "arm64"

    enum CodingKeys: String, CodingKey {
        case email = "Email"
        case password = "Password"
        case idfa = "Idfa"
        case uniqueDeviceId = "UniqueDeviceIdentifier"
        case deviceId = "DeviceIdentifier"
    }
    
    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
