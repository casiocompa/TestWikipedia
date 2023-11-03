//
//  PlacesPresenter.swift
//  TestWikipedia
//
//  Created by Ruslan Kasian Dev_2 on 31.10.2023.
//

import Foundation
import Moya

final class PlacesPresenter {
    
    func getList(_ completion: @escaping ([PlaceObject]?) -> Void) {
        placesProvider.request(.getPlacesList) { result in
            switch result {
            case let .success(response):
                let decodedResult: Result<[PlaceObject], Error> = GenericDecoderManager.shared.decodeMany(response.data)
                switch decodedResult {
                case let .success(object):
                    
                    realmDB.updateObjects(object)
                    completion(object)
                case let .failure(error):
                    print(error.localizedDescription)
                    completion(nil)
                }
            case let .failure(error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
