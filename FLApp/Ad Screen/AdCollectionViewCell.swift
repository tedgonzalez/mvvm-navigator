//
//  AdCollectionViewCell.swift
//  FLApp
//
//  Created by Theodore Gonzalez on 4/30/18.
//  Copyright © 2018 wandercodesfze. All rights reserved.
//

import UIKit

class AdCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Internal properties
    
    @IBOutlet weak private var adImageView: UIImageView!
    @IBOutlet weak private var favoriteButton: UIButton!
    @IBOutlet weak private var buttonBackgroundView: UIView!
    @IBOutlet weak private var priceBackgroundView: UIView!
    @IBOutlet weak private var priceLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var locationLabel: UILabel!
    
    // MARK: - Setup
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 2
        backgroundColor = .white
        
        priceLabel.textColor = .white
        priceLabel.font = UIFont(name: FontType.regular.rawValue, size: 12)
        titleLabel.font = UIFont(name: FontType.light.rawValue, size: 12)
        locationLabel.font = UIFont(name: FontType.light.rawValue, size: 12)
        favoriteButton.tintColor = .white
        favoriteButton.addTarget(self, action: #selector(didTapFavorite(sender:)), for: .touchDown)
        let color = UIColor(white: 0, alpha: 0.5)
        buttonBackgroundView.backgroundColor = color
        priceBackgroundView.backgroundColor = color
    }
    
    // MARK: - Dependency injection
    
    public var model: AdItemViewModel? {
        didSet {
            titleLabel.text = model?.titleText
            priceLabel.text = model?.priceText
            locationLabel.text = model?.locationText
            adImageView.kf.setImage(with: model?.downloadUrl)
            if let model = model, model.isFavorite == true {
                favoriteButton.setImage(UIImage(named: "heartSelected"), for: .normal)
            } else {
                favoriteButton.setImage(UIImage(named: "heart"), for: .normal)
            }
        }
    }
    
    
    // MARK: - Actions
    
    @objc func didTapFavorite(sender: UIButton) {
        if let model = self.model {
            model.isFavorite = !model.isFavorite
        }
    }
}
