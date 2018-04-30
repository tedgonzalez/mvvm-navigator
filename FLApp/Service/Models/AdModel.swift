//
//  AdModel.swift
//  FLApp
//
//  Created by Theodore Gonzalez on 4/30/18.
//  Copyright © 2018 wandercodesfze. All rights reserved.
//

import Foundation

public struct AdModel: Codable {
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
