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

class FilterViewModel {
    
    // MARK: - External properties
    
    public let title = "Select filter"
    public let items:[FilterOption] = FilterOption.all
    public var selectedOption: FilterOption {
        didSet {
            self.delegate?.didChangeFilterOptions(option: selectedOption)
        }
    }
    
    // MARK: - Internal properties
    
    private weak var delegate:UpdateFilterOptionsDelegate?
    
    // MARK: - Setup
    
    public init(delegate:UpdateFilterOptionsDelegate?, selectedOption: FilterOption = .showAll) {
        self.delegate = delegate
        self.selectedOption = selectedOption
    }
    
    // MARK: - External methods
    
    public func didSelectOptionAtRow(row: Int) {
        var toggledOption = self.items[row]
        if selectedOption == toggledOption {
            toggledOption = .showAll
        }
        selectedOption = toggledOption
    }
}
