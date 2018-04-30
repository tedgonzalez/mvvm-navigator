//
//  Ad.swift
//  FLApp
//
//  Created by Theodore Gonzalez on 4/30/18.
//  Copyright © 2018 wandercodesfze. All rights reserved.
//

import Foundation

public struct AdContainer: Decodable {
    
    public let size: Int?
    public let items: [AdModel]?
    public let version: String?
    public let uuid: String
    
    init(size: Int? = nil,
         items: [AdModel]? = nil,
         version: String? = nil,
         uuid: String) {
        self.size = size
        self.items = items
        self.version = version
        self.uuid = uuid
    }
}

extension AdContainer: Hashable {
    public var hashValue: Int {
        return Int(self.uuid)!
    }
    
    public static func == (lhs: AdContainer, rhs: AdContainer) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}

public struct AdModel: Decodable {
    public let adId: String
    /// Can be one of the following ["REALESTATE", "CAR", "JOB", "BAP"]
    public let adType: String
    public let image: ImageModel?
    public let location: String?
    
    public let price: PriceModel?
    public let adDescription: String?
    
    init?(adId: String,
          adType: String,
          image: ImageModel? = nil,
          location: String? = nil,
          price: PriceModel? = nil,
          adDescription: String? = nil) {
        self.adId = adId
        self.adType = adType
        self.image = image
        self.location = location
        self.price = price
        self.adDescription = adDescription
    }
    enum CodingKeys: String, CodingKey {
        case adId = "id"
        case adType = "ad-type"
        case image
        case location
        case price
        case adDescription = "description"
    }
}

extension AdModel:Hashable {
    public var hashValue: Int {
        return Int(self.adId)!
    }
    
    public static func == (lhs: AdModel, rhs: AdModel) -> Bool {
        return lhs.adId == rhs.adId
    }
}


public struct ImageModel: Decodable {
    public let url: String?
    
    init(url: String? = nil) {
        self.url = url
    }
    
}

public struct PriceModel: Decodable {
    public let value: Int?
    
    init(value: Int? = nil) {
        self.value = value
    }
}
