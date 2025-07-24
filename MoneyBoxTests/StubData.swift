//
//  StubData.swift
//  MoneyBoxTests
//
//  Created by Zeynep Kara on 17.01.2022.
//

import Foundation
@testable import MoneyBox

struct StubData {
    static func read<T: Decodable>(file: String, callback: @escaping (Result<T, Error>) -> Void) {
        if let path = Bundle.main.path(forResource: file, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let result = try JSONDecoder().decode(T.self, from: data)
                callback(.success(result))
            } catch {
                callback(.failure(error))
            }
        } else {
            callback(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Couldn't create path"])))
        }
    }
}
