//
//  AdDetailViewController.swift
//  FLApp
//
//  Created by Theodore Gonzalez on 4/30/18.
//  Copyright © 2018 wandercodesfze. All rights reserved.
//
import UIKit

class AdDetailViewController: UIViewController {
    
    // MARK: - Internal properties
    
    @IBOutlet weak private var ivAdPhoto: UIImageView!
    @IBOutlet weak private var textView: UITextView!
    
    // MARK: - External properties
    
    public var item: AdItemViewModel?
    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        self.ivAdPhoto.kf.setImage(with: self.item?.downloadUrl)
        self.textView.text = self.item?.detailText
    }
    deinit {
        print(String(describing: self) + "is deallocated")
    }
}
