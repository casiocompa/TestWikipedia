//
//  APIConstants.swift
//  TestWikipedia
//
//  Created by Ruslan Kasian Dev_2 on 30.10.2023.
//

import Foundation

struct APIConstants {
    static let baseApiStr = "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/"
    static let baseApiURL = URL(string: baseApiStr)!
}

public typealias APIHeaders = [String: String]?
public typealias APIParameters = [String: Any]

struct APIRequestContentType {
    static let json: [String : String] = ["Content-type": "application/json"]
}
