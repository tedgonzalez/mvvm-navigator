//
//  Navigator.swift
//  FLApp
//
//  Created by Theodore Gonzalez on 5/1/18.
//  Copyright © 2018 wandercodesfze. All rights reserved.
//

import Foundation

protocol Navigator {
    associatedtype Destination
    
    func start()
    func navigate(to destination: Destination)
}
