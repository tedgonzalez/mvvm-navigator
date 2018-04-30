//
//  URLSessionProtocol.swift
//  FLApp
//
//  Created by Theodore Gonzalez on 4/30/18.
//  Copyright © 2018 wandercodesfze. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    func dataTaskWithURL(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

extension URLSession: URLSessionProtocol {
    
    func dataTaskWithURL(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        let task:URLSessionDataTask = dataTask(with: url, completionHandler: {
            (data:Data?, response:URLResponse?, error:Error?) in completionHandler(data,response,error) }) as URLSessionDataTask;
        return task
    }
}
