//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import UIKit

import Foundation

public protocol Identifiable {
    static var reuseIdentifier: String { get }
}

public extension Identifiable {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: Identifiable {}

public extension UICollectionView {
    public func register(_ cellClass: UICollectionViewCell.Type) {
        register(cellClass.self, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
    }

    public func registerNib(_ cellClass: UICollectionViewCell.Type) {
        register(UINib(nibName: String(describing: cellClass), bundle: nil), forCellWithReuseIdentifier: cellClass.reuseIdentifier)
    }

    public func dequeue<T>(_ cellClass: T.Type, for indexPath: IndexPath) -> T where T: UICollectionViewCell {
        return dequeueReusableCell(withReuseIdentifier: cellClass.reuseIdentifier, for: indexPath) as! T
    }
}
