//
//  ViewController.swift
//  FLApp
//
//  Created by Theodore Gonzalez on 4/30/18.
//  Copyright © 2018 wandercodesfze. All rights reserved.
//

import UIKit
import Kingfisher
import Disk
class AdViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var navigator: AdsNavigator?
    var viewModel: AdViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.lightGray
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: NSNotification.Name(rawValue: AdViewModelNotification.filterUpdate.rawValue), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? AdDetailViewController {
            if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                let item = viewModel?.visibleAdViewModels[indexPath.row]
                destinationVC.item = item
            }
        }
    }
    
    @IBAction func didTapFilter(_ sender: UIBarButtonItem) {
        navigator?.navigate(to: .filterScreen)
    }
    
    // MARK: - Did Update filter
    @objc func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension AdViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel!.visibleAdViewModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = viewModel?.visibleAdViewModels[indexPath.row]
        let cell = collectionView.dequeue(AdCollectionViewCell.self, for: indexPath)
        cell.model = item
        cell.didTapFavoriteBlock = {(sender) in
            collectionView.reloadItems(at: [indexPath])
        }
        return cell
    }
}

extension AdViewController: UICollectionViewDelegate {
    
}

extension AdViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let urls = indexPaths.compactMap { indexPath in
            return viewModel?.visibleAdViewModels[indexPath.row].downloadUrl
        }
        ImagePrefetcher(urls: urls).start()
    }
}

extension AdViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return margin();
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width/2.0 - margin()
        let height = CGFloat(200)
        return CGSize(width: width, height: height)
    }
    private func margin() -> CGFloat {
        return CGFloat(8)
    }
}
