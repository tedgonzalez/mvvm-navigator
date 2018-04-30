//
//  AdModel.swift
//  FLApp
//
//  Created by Theodore Gonzalez on 4/30/18.
//  Copyright © 2018 wandercodesfze. All rights reserved.
//

import Foundation

public struct PriceModel: Codable {
    public let value: Int?
    
    init(value: Int? = nil) {
        self.value = value
    }
}
