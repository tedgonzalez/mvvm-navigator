//
//  FLAppTests.swift
//  FLAppTests
//
//  Created by Theodore Gonzalez on 4/30/18.
//  Copyright © 2018 wandercodesfze. All rights reserved.
//

import XCTest
@testable import FLApp

class FLAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAdContainerMapping() {
        //given
        let json = jsonData(fromResource: "ADCONTAINER")
        
        //when
        let container = try! JSONDecoder().decode(AdContainer.self, from: json)
        
        //then
        XCTAssert(container.size == 5957)
        XCTAssert(container.version == "finn_meta_discovery_2b")
        XCTAssert(container.uuid == "80ec2f0c-44c9-435a-aeec-99e164304de9")
        XCTAssert(container.items?.count == 1)
        
        let item = container.items!.first!
        XCTAssert(item.image?.url == "2017/9/vertical-5/30/5/105/424/_1263219766.jpg")
        XCTAssert(item.adType == "BAP")
        XCTAssert(item.price?.value == 300)
        XCTAssert(item.adDescription == "Legemidler og bruken av dem")
        XCTAssert(item.location == "Laksevåg")
    }
}


