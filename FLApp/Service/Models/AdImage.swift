//
//  AdModel.swift
//  FLApp
//
//  Created by Theodore Gonzalez on 4/30/18.
//  Copyright © 2018 wandercodesfze. All rights reserved.
//

import Foundation

public struct ImageModel: Codable {
    public let url: String?
    
    init(url: String? = nil) {
        self.url = url
    }
}
