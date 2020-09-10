//
//  VerticalCollectionViewCell.swift
//  TVManager
//
//  Created by Emad Albarnawi on 06/09/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit;

protocol customHorizantalCollectionViewDelegate {
    func reloadeCollectionView();
}

class VerticalCollectionViewCell: UICollectionViewCell, customHorizantalCollectionViewDelegate {
    var homeViewController: HomeViewController?;
    func reloadeCollectionView() {
        horizantalCollectionView.reloadData();
    }
    

    @IBOutlet weak var horizantalCollectionView: UICollectionView!
    
    lazy var horizantalCollectionViewController = HorizantalCollectionViewController();
    override func layoutSubviews() {
//        homeViewController?.custom = self;
//        print(homeViewController)
        horizantalCollectionView.delegate = horizantalCollectionViewController;
        horizantalCollectionView.dataSource = horizantalCollectionViewController;
        
        reloadeCollectionView();
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame);
        horizantalCollectionView.delegate = horizantalCollectionViewController;
        horizantalCollectionView.dataSource = horizantalCollectionViewController;
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
        
//        fatalError("init(coder:) has not been implemented")
    }
    
}

