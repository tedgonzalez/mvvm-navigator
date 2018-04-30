//
//  XCTestCase+json.swift
//  FLAppTests
//
//  Created by Theodore Gonzalez on 4/30/18.
//  Copyright © 2018 wandercodesfze. All rights reserved.
//

import XCTest

extension XCTestCase {
    func jsonData(fromResource resource:String) -> Data {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: resource, ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!), options:.alwaysMapped)
        return data
    }
}
