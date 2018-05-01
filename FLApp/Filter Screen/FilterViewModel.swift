//
//  FilterViewModel.swift
//  FLApp
//
//  Created by Theodore Gonzalez on 5/1/18.
//  Copyright © 2018 wandercodesfze. All rights reserved.
//

import UIKit

protocol UpdateFilterOptionsDelegate: class {
    func didChangeFilterOptions(option: FilterOption)
}

public enum FilterOption:String {
    case showFavorites = "Show Favorites"
    case showAll = "Show All"
    public static var all:[FilterOption] = [.showFavorites, .showAll]
}

class FilterOptionItem {
    let title: String
    var isSelected: Bool
    
    init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }
}

class FilterViewModel {
    let items:[FilterOptionItem] = {
        return FilterOption.all.map({ (option) -> FilterOptionItem in
            FilterOptionItem(title: option.rawValue, isSelected: false)
        })
    }()
    
    private weak var delegate:UpdateFilterOptionsDelegate?
    public init(delegate:UpdateFilterOptionsDelegate?) {
        self.delegate = delegate
    }
    
    public func didSelectOptionAtRow(row: Int) {
        let item = self.items[row]
        item.isSelected = !item.isSelected
        let selectedOptions = items.filter { (optionItem) -> Bool in
            return optionItem.isSelected
            }.map { (optionItem) -> FilterOption in
                return FilterOption(rawValue: optionItem.title)!
        }
        if let selectedOption = selectedOptions.first {
            self.delegate?.didChangeFilterOptions(option: selectedOption)
        } else {
            self.delegate?.didChangeFilterOptions(option: .showAll)
        }
    }
}
