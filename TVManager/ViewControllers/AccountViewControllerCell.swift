//
//  AccountViewControllerCell.swift
//  TVManager
//
//  Created by Emad Albarnawi on 25/09/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit

class AccountViewControllerCell: UICollectionViewCell {
//    @IBOutlet weak var accountHorizantalCollectionView: UICollectionView!
    @IBOutlet weak var accountHorizantalCollectionView: UICollectionView!
    
    lazy var accountHorizantalCollectionViewController: AccountHorizantalCollectionViewController = AccountHorizantalCollectionViewController();
    
//    var favoritResponse: GetPopularResponse? = nil {
//        didSet {
//            accountHorizantalCollectionViewController.favoritResponse = favoritResponse;
//            accountHorizantalCollectionView.reloadData();
//        }
//    }
    var data: [UIImage?] = [] {
        didSet {
            accountHorizantalCollectionViewController.data = data;
            accountHorizantalCollectionView.reloadData();
        }
    }

    
    override func layoutSubviews() {
        accountHorizantalCollectionView.delegate = accountHorizantalCollectionViewController;
        accountHorizantalCollectionView.dataSource = accountHorizantalCollectionViewController;
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
//        horizantalCollectionView.delegate = horizantalCollectionViewController;
//        horizantalCollectionView.dataSource = horizantalCollectionViewController;
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
        
//        fatalError("init(coder:) has not been implemented")
    }
}

