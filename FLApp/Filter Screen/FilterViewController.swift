//
//  FilterViewController.swift
//  FLApp
//
//  Created by Theodore Gonzalez on 5/1/18.
//  Copyright © 2018 wandercodesfze. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    var viewModel:FilterViewModel?
    @IBOutlet weak private var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = false
    }
}

extension FilterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.items.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(UITableViewCell.self, for: indexPath)
        if let item = viewModel?.items[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.isSelected ? .checkmark : .none
        }
        return cell
    }
}

extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vm = viewModel {
            vm.didSelectOptionAtRow(row: indexPath.row)
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}
