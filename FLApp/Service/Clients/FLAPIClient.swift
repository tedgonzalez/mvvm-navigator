//
//  FLAPIClient.swift
//  FLApp
//
//  Created by Theodore Gonzalez on 4/30/18.
//  Copyright © 2018 wandercodesfze. All rights reserved.
//

import Foundation

public class FLAPIClient {
    private let baseUrl = "https://gist.githubusercontent.com/3lvis/"
    private let session: URLSessionProtocol
    let sess = URLSession(configuration: .default)
    init(session: URLSessionProtocol = URLSession(configuration: .default)) {
        self.session = session
    }
    public func send<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<T.Response>) {
        let url = self.finalUrl(for: request)
        let task = session.dataTaskWithURL(with: url) { data, response, error in
            if let data = data {
                do {
                    let container = try JSONDecoder().decode(T.Response.self, from: data)
                    completion(.success(container))
                } catch {
                    print("some error \(error.localizedDescription)")
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    /// Create url based on baseUrl and request
    ///
    ///
    private func finalUrl<T: APIRequest>(for request: T) -> URL {
        return URL(string: "\(baseUrl)\(request.path)")!
    }
}
