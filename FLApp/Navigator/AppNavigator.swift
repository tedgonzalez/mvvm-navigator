//
//  AppNavigator.swift
//  FLApp
//
//  Created by Theodore Gonzalez on 5/1/18.
//  Copyright © 2018 wandercodesfze. All rights reserved.
//

import UIKit

class AppNavigator {
    private let window:UIWindow
    private var navigator:AdsNavigator?
    public init(window: UIWindow) {
        self.window = window
    }
    
    private func showAdScreen() {
        let nav = UINavigationController()
        AdsNavigator(navigationController: nav).start()
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
}

extension AppNavigator: Navigator {
    enum Destination {
        case root
    }
    
    func start() {
        navigate(to: .root)
    }
    
    func navigate(to destination: AppNavigator.Destination) {
        switch destination {
        case .root:
            showAdScreen()
        }
    }
}
