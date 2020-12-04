//
//  VerticalCollectionViewCell.swift
//  TVManager
//
//  Created by Emad Albarnawi on 06/09/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit;

class VerticalCollectionViewCell: UICollectionViewCell {
    var data:[UIImage?] = [] {
        didSet {
            horizantalCollectionViewController.data = data;
            horizantalCollectionView.reloadData();
        }
    }
    var response: Response? {
        didSet {
            horizantalCollectionViewController.response = response;
            horizantalCollectionView.reloadData();
        }
    }

    @IBOutlet weak var horizantalCollectionView: UICollectionView!
    
    lazy var horizantalCollectionViewController = HorizantalCollectionViewController();

    override func layoutSubviews() {
        horizantalCollectionView.delegate = horizantalCollectionViewController;
        horizantalCollectionView.dataSource = horizantalCollectionViewController;
    }
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
    }
    
}

