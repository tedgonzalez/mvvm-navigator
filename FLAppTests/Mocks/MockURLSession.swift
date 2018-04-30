//
//  MockURLSession.swift
//  FLAppTests
//
//  Created by Theodore Gonzalez on 4/30/18.
//  Copyright © 2018 wandercodesfze. All rights reserved.
//

import Foundation
@testable import FLApp

class MockURLSession: URLSessionProtocol {
    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextResponse: URLResponse?
    var nextError: Error?
    
    private (set) var lastURL: URL?
    
    func dataTaskWithURL(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        lastURL = url
        completionHandler(nextData, nextResponse, nextError)
        return nextDataTask
    }
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var taskDidResume = false
    func resume() {
        taskDidResume = true
    }
}
