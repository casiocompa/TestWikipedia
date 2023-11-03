//
//  PlacesApiService.swift
//  TestWikipedia
//
//  Created by Ruslan Kasian Dev_2 on 30.10.2023.
//

import Moya

let placesProvider = MoyaProvider<PlacesApiService>()

enum PlacesApiService {
    case getPlacesList
}

extension PlacesApiService: TargetType {
    var baseURL: URL {
        return APIConstants.baseApiURL
    }
    
    var headers: APIHeaders {
        return nil
    }
    
    var path: String {
        switch self {
        case .getPlacesList:
            return "main/locations.json"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "Test data".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        return .requestPlain
    }
}
