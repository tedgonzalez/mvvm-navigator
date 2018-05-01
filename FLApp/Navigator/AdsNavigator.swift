//
//  AdsNavigator.swift
//  FLApp
//
//  Created by Theodore Gonzalez on 5/1/18.
//  Copyright © 2018 wandercodesfze. All rights reserved.
//

import UIKit

class AdsNavigator {
    private weak var navigationController: UINavigationController?
    private let adViewModel: AdViewModel = AdViewModel()
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
}

extension AdsNavigator: Navigator {
    enum Destination {
        case adListScreen
        case filterScreen
    }
    
    func start() {
        navigate(to: .adListScreen)
    }
    
    func navigate(to destination: AdsNavigator.Destination) {
        switch destination {
        case .adListScreen:
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: AdViewController.self)) as! AdViewController
            vc.navigator = self
            vc.viewModel = adViewModel
            navigationController?.setViewControllers([vc], animated: false)
        case .filterScreen:
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: FilterViewController.self)) as! FilterViewController
            vc.viewModel = FilterViewModel(delegate: adViewModel)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
