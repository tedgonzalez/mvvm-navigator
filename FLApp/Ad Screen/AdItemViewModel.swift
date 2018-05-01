//
//  AdItemViewModel.swift
//  FLApp
//
//  Created by Theodore Gonzalez on 4/30/18.
//  Copyright © 2018 wandercodesfze. All rights reserved.
//

import Foundation
protocol UpdateFavoritesDelegate: class {
    func didAddFavorite(favorite:AdModel)
    func didRemoveFavorite(favorite:AdModel)
}
class AdItemViewModel {
    let model: AdModel
    let downloadUrl: URL?
    let priceText: String
    let locationText: String
    let titleText: String
    private weak var delegate:UpdateFavoritesDelegate?
    var isFavorite: Bool {
        didSet {
            if isFavorite {
                delegate?.didAddFavorite(favorite: model)
            } else {
                delegate?.didRemoveFavorite(favorite: model)
            }
        }
    }
    
    init(model: AdModel, isFavorite: Bool = true, delegate:UpdateFavoritesDelegate?) {
        self.model = model
        if let imgURL = model.image?.url {
            let baseUrl = "https://images.finncdn.no/dynamic/480x360c/"
            self.downloadUrl = URL(string: "\(baseUrl)\(imgURL)")!
        } else {
            self.downloadUrl = nil
        }
        
        if let price = model.price?.value  {
            self.priceText = "\(price)"
        } else {
            self.priceText = ""
        }
        
        self.locationText = model.location ?? ""
        self.titleText = model.adDescription ?? ""
        self.delegate = delegate
        self.isFavorite = isFavorite
    }
}
