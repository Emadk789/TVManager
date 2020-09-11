//
//  VerticalCollectionViewCell.swift
//  TVManager
//
//  Created by Emad Albarnawi on 06/09/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit;

//protocol customHorizantalCollectionViewDelegate {
//    func reloadeCollectionView();
//}

class VerticalCollectionViewCell: UICollectionViewCell {
//    var homeViewController: HomeViewController?;
//    func reloadeCollectionView() {
//        horizantalCollectionView.reloadData();
//    }
    var data:[UIImage?] = [] {
        didSet {
//            collectionView.releadData()
//            horizantalCollectionView.data
            horizantalCollectionViewController.data = data;
            horizantalCollectionView.reloadData();
        }
    }

    @IBOutlet weak var horizantalCollectionView: UICollectionView!
    
    lazy var horizantalCollectionViewController = HorizantalCollectionViewController();
    enum HorizantalCollectionViewType {
        case tv, movie;
    }
    static var type: HorizantalCollectionViewType = .tv;
    override func layoutSubviews() {
//        homeViewController?.custom = self;
//        print(homeViewController)
//        enum what {
//
//        }
//        let type = WhatType.movie
//        switch type {
//        case .tv:
//            break
//        default:
//            break
//        }
        print("layoutSubViews", VerticalCollectionViewCell.type)
        horizantalCollectionView.delegate = horizantalCollectionViewController;
        horizantalCollectionView.dataSource = horizantalCollectionViewController;
//        switch VerticalCollectionViewCell.type {
//        case .tv:
//            horizantalCollectionView.delegate = horizantalCollectionViewController;
//            horizantalCollectionView.dataSource = horizantalCollectionViewController;
////            horizantalCollectionViewController.type = .tv;
////            horizantalCollectionViewController.data = data;
////            horizantalCollectionView.reloadData();
//        default:
//            horizantalCollectionViewController.type = .movie;
//            break;
//        }
//        horizantalCollectionView.delegate = horizantalCollectionViewController;
//        horizantalCollectionView.dataSource = horizantalCollectionViewController;
        
//        horizantalCollectionView.reloadData();
        
    }
    func test() {}
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

