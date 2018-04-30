//
//  FLAPIClientTests.swift
//  FLAppTests
//
//  Created by Theodore Gonzalez on 4/30/18.
//  Copyright © 2018 wandercodesfze. All rights reserved.
//

import XCTest
@testable import FLApp

class FLAPIClientTests: XCTestCase {
    let testBaseUrl = "https://gist.githubusercontent.com/3lvis/"
    let testAdsUrl = "3799feea005ed49942dcb56386ecec2b/raw/63249144485884d279d55f4f3907e37098f55c74/discover.json"
    var client: FLAPIClient!
    let session = MockURLSession()
    override func setUp() {
        super.setUp()
        client = FLAPIClient(session: session)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetAdsHasURL() {
        XCTAssertEqual(GetAds().path, testAdsUrl)
    }
    
    func testGetAdsCompleteURL() {
        client.send(GetAds()) { (result) in }
        
        //then
        let url = URL(string: "\(testBaseUrl)\(testAdsUrl)")!
        XCTAssert(session.lastURL == url)
    }
    
    func testGetStartsRequest() {
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        client.send(GetAds()) { (result) in }
        
        //then
        XCTAssertTrue(dataTask.taskDidResume)
    }
    
    func testGetAdsReturnsData() {
        //given
        let json = jsonData(fromResource: "ADCONTAINER")
        let testContainer = try! JSONDecoder().decode(AdContainer.self, from: json)
        session.nextData = json
        
        //when
        client.send(GetAds()) { (response) in
            //then
            switch response {
            case .success(let container):
                XCTAssert(container == testContainer)
            default:
                XCTFail()
            }
        }
    }
    func testGetAdsReturnsError() {
        //given
        session.nextError = NSError(domain: "error", code: 0, userInfo: nil)
        
        //when
        client.send(GetAds()) { (response) in
            switch response {
            case .failure(let error):
                XCTAssertNotNil(error)
            default:
                XCTFail()
            }
        }
    }
}




