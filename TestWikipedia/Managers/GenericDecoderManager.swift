//
//  GenericDecoderManager.swift
//  TestWikipedia
//
//  Created by Ruslan Kasian Dev_2 on 01.11.2023.
//

import Foundation

class GenericDecoderManager {
    static let shared = GenericDecoderManager()
    private let jsonDecoder = JSONDecoder()
    
    func decodeMany<Entity: Decodable>(_ data: Data) -> Result<[Entity], Error> {
        do {
            let decodedResponse = try jsonDecoder.decode(GenericResponseMany<Entity>.self, from: data)
            return .success(decodedResponse.data)
        } catch let error {
            print("Error decode:", error.localizedDescription)
            return .failure(error)
        }
    }
}

struct GenericResponseMany<T: Decodable>: Decodable {
    let data: [T]
    
    enum CodingKeys: String, CodingKey {
        case data = "locations"
    }
}
