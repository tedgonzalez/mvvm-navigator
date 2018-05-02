//
//  AdViewModel.swift
//  FLApp
//
//  Created by Theodore Gonzalez on 4/30/18.
//  Copyright © 2018 wandercodesfze. All rights reserved.
//

import Foundation
import Disk

protocol VisibleItemsObserver: class {
    func didUpdateVisibleItems()
}

protocol VisibleItemsObservable: class {
    func addObserver(observer: VisibleItemsObserver)
    func removeObserver(observer: VisibleItemsObserver)
    func notifyObservers()
}

class AdViewModel {
    
    // MARK: - Internal properties
    
    private var availableAds: [AdModel] = []
    private var favorites: [AdModel] = []
    private var availableAdViewModels: [AdItemViewModel] = []
    private var observers: [VisibleItemsObserver] = []
    
    // MARK: - External properties
    
    public weak var navigator: AdsNavigator?
    public private(set) var selectedOption: FilterOption = .showAll
    public private(set) var visibleAdViewModels: [AdItemViewModel] = [] {
        didSet {
            self.notifyObservers()
        }
    }
    
    // MARK: - Setup
    
    init() {
        self.favorites = retrieveFavorites()
        updateAvailableAdViewModels()
    }
    
    private func updateAvailableAdViewModels() {
        availableAdViewModels.removeAll()
        availableAdViewModels = availableAds.map { ad in
            AdItemViewModel(model: ad, isFavorite: favorites.contains(ad), delegate:self)
        }
        for ad in favorites {
            if availableAds.contains(ad) == false {
                availableAdViewModels.append(AdItemViewModel(model: ad, isFavorite: true, delegate:self))
            }
        }
        self.visibleAdViewModels = self.availableAdViewModels
    }
    
     // MARK: - External methods
    
    public func getAds(with completion:@escaping () -> Void) {
        FLAPIClient().send(GetAds()) {[weak self] (response) in
            switch response {
            case .success(let container):
                if let ads = container.items {
                    self?.availableAds = ads
                    self?.updateAvailableAdViewModels()
                }
                
                completion()
            case .failure(let error):
                self?.navigator?.navigate(to: .alert(message: error.localizedDescription))
                completion()
            }
        }
    }
}

// MARK: - Storage

extension AdViewModel {
    func retrieveFavorites() -> [AdModel] {
        if let retrieved = try? Disk.retrieve(fileName(), from: .caches, as: [AdModel].self) {
            return retrieved
        } else {
            return []
        }
    }
    func saveFavorite(favorite: AdModel) {
        try? Disk.append(favorite, to:fileName(), in:.caches)
    }
    func saveFavorites() {
        try? Disk.save(favorites, to:.caches, as:fileName())
    }
    func fileName() -> String {
        return "favorites.json"
    }
}

extension AdViewModel: UpdateFavoritesDelegate {
    func didAddFavorite(favorite: AdModel) {
        favorites.append(favorite)
        saveFavorite(favorite: favorite)
        self.notifyObservers()
    }
    
    func didRemoveFavorite(favorite: AdModel) {
        guard let index = favorites.index(of: favorite) else {
            return
        }
        
        favorites.remove(at: index)
        saveFavorites()
        if selectedOption == .showFavorites {
            visibleAdViewModels = availableAdViewModels.filter({ (model) -> Bool in
                return model.isFavorite
            })
        } else {
            self.notifyObservers()
        }
    }
}

extension AdViewModel: UpdateFilterOptionsDelegate {
    func didChangeFilterOptions(option: FilterOption) {
        selectedOption = option
        visibleAdViewModels.removeAll()
        switch option {
        case .showAll:
            visibleAdViewModels = availableAdViewModels
        case .showFavorites:
            visibleAdViewModels = availableAdViewModels.filter({ (model) -> Bool in
                return model.isFavorite
            })
        }
    }
}

extension AdViewModel: VisibleItemsObservable {
    func addObserver(observer: VisibleItemsObserver) {
        if observers.contains(where: { $0 === observer }) == false {
            observers.append(observer)
        }
    }
    
    func removeObserver(observer: VisibleItemsObserver) {
        if let index = observers.index(where: { $0 === observer }) {
            observers.remove(at: index)
        }
    }
    
    func notifyObservers() {
        observers.forEach { (observer) in
            observer.didUpdateVisibleItems()
        }
    }
}
