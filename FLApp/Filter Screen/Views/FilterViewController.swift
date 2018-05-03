//
//  FilterViewController.swift
//  FLApp
//
//  Created by Theodore Gonzalez on 5/1/18.
//  Copyright © 2018 wandercodesfze. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    // MARK: - Internal properties
    
    @IBOutlet weak private var tableView: UITableView!
    
    // MARK: - External properties
    
    public var viewModel:FilterViewModel?
    
    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = false
        title = viewModel?.title
    }
    
    deinit {
        print(String(describing: self) + "is deallocated")
    }
}

extension FilterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(UITableViewCell.self, for: indexPath)
        if let vm = viewModel {
            let option = vm.items[indexPath.row]
            cell.textLabel?.text = option.rawValue
            cell.accessoryType = vm.selectedOption == option ? .checkmark : .none
        }
        return cell
    }
}

extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vm = viewModel {
            vm.didSelectOptionAtRow(row: indexPath.row)
            tableView.reloadData()
        }
    }
}
