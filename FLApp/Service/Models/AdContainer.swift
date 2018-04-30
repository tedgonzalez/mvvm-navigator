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


