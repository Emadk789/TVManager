//
//  AccountHorizantalCollectionViewController.swift
//  TVManager
//
//  Created by Emad Albarnawi on 25/09/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class AccountHorizantalCollectionViewController: CollectionView, UICollectionViewDataSource {
    
    var favoritResponse: GetPopularResponse? = nil;
    var data: [UIImage?] = [];
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return data.count;
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AccountHorizantalCollectionViewCell;
        cell.backgroundColor = .systemBlue;
        // Configure the cell
//        let image = UIImage(data: data[indexPath.item]);
        cell.imageView.image = data[indexPath.item];
//        print("This is the poster Path", image);
    
        return cell
    }

    // MARK: UICollectionViewDelegate

}

//extension AccountHorizantalCollectionViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size: CGSize;
//
//        let bounds = collectionView.bounds;
//        let minSpacingForLine: CGFloat = 10;
//        let numberOfCells: CGFloat = 3;
//        let constant: CGFloat = 1.5;
//        let width: CGFloat = (bounds.width-(minSpacingForLine*numberOfCells*constant))/numberOfCells;
//        size = CGSize(width: width, height: collectionView.bounds.height);
//        
//        return size;
//    }
//}
