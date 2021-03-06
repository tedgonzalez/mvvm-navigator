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
        self.adViewModel.navigator = self
    }
}

extension AdsNavigator: Navigator {
    enum Destination {
        case adListScreen
        case filterScreen
        case alert(message: String)
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
            vc.viewModel = FilterViewModel(delegate: adViewModel, selectedOption: adViewModel.selectedOption)
            navigationController?.pushViewController(vc, animated: true)
        case .alert(let message):
            let alert = UIAlertController(title: "Oops", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            navigationController?.present(alert, animated: true, completion: nil)
        }
    }
}
