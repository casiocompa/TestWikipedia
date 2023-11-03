//
//  PlaceModel.swift
//  TestWikipedia
//
//  Created by Ruslan Kasian Dev_2 on 30.10.2023.
//

import RealmSwift

@objcMembers
class PlaceObject: Object, ObjectCodableProtocol, FullStringMakerProtocol {
    dynamic var name:               String? = nil
    dynamic var latitude:           Double = 0.0
    dynamic var longitude:          Double = 0.0
    
    dynamic var coordinatePrimary:  String = ""
    
    var fullnameStr: String? {
        return name
    }
    
    var latitudeStr: String? {
        return "".stringMakerWithSeparator(
            texts: [
                "latitude",
                latitude.toString(),
            ],
            separator: ": "
        )
    }
    
    var longitudeStr: String? {
        return "".stringMakerWithSeparator(
            texts: [
                "longitude",
                longitude.toString(),
            ],
            separator: ": "
        )
    }
    
    override class func primaryKey() -> String? {
        return "coordinatePrimary"
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case latitude = "lat"
        case longitude = "long"
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        name                = try container.decodeIfPresent(String.self, forKey: .name)

        if let latitudeStr: Double  = try container.decodeIfPresent(Double.self,  forKey: .latitude) {
            self.latitude           = latitudeStr
        }else if let latitudeStr: String  = try container.decodeIfPresent(String.self,  forKey: .latitude) {
            self.latitude            = latitudeStr.toDouble ?? 0.0
        }else {
            self.latitude            = 0.0
        }
        
        if let longitudeStr: Double  = try container.decodeIfPresent(Double.self,  forKey: .longitude) {
            self.longitude          = longitudeStr
        }else if let longitudeStr: String  = try container.decodeIfPresent(String.self,  forKey: .longitude) {
            self.longitude          = longitudeStr.toDouble ?? 0.0
        }else {
            self.longitude          = 0.0
        }
        
        self.coordinatePrimary = "coordinatePrimary".stringMakerWithSeparator(
            texts: [
                latitude.toString(),
                longitude.toString()
            ],
            separator: "-"
        ) ?? ""
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(name,         forKey: .name)
        try container.encodeIfPresent(latitude,     forKey: .latitude)
        try container.encodeIfPresent(longitude,    forKey: .longitude)
    }
}
