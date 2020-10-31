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
//    @IBOutlet weak var segmentView: UISegmentedControl!
//    @IBOutlet weak var accountHorizantalCollectionViewLabel: UILabel!
    
    lazy var accountHorizantalCollectionViewController: AccountHorizantalCollectionViewController = AccountHorizantalCollectionViewController();
    var cellNumber = Int()
    
//    var favoritResponse: GetPopularResponse? = nil {
//        didSet {
//            accountHorizantalCollectionViewController.favoritResponse = favoritResponse;
//            accountHorizantalCollectionView.reloadData();
//        }
//    }
    var data: [UIImage?] = [] {
        didSet {
            accountHorizantalCollectionViewController.data = data;
            accountHorizantalCollectionViewController.cellNumber = cellNumber;
            accountHorizantalCollectionView.reloadData();
        }
    }
//    @IBAction func segmentViewClicked(_ sender: Any) {
//        let index = segmentView.selectedSegmentIndex;
//        let cell = cellNumber;
//    }
    
//    override func prepareForReuse() {
//        segmentView.setEnabled(true, forSegmentAt: 0)
//        segmentView.selectedSegmentIndex = 0;
////        let x = segmentView.isSelected;
//    }
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

