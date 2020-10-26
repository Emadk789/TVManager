//
//  HorizantalCollectionView.swift
//  TVManager
//
//  Created by Emad Albarnawi on 06/09/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit

class HorizantalCollectionViewController: CollectionView, UICollectionViewDataSource {
    var data: [UIImage?] = []
    var response: Response?

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var number4 = data.count;
        number4 = (response?.data.count) ?? 0;
        
        return number4;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HorizantalCollectionViewCell;
        cell.backgroundColor = .systemBlue;
//        cell.imageView.image = data[indexPath.item];
        cell.imageView.image = response?.data[indexPath.item];
        print("This is the Media ID", response?.response.results[indexPath.item].id)
        return cell;
    }
}

//extension HorizantalCollectionViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size: CGSize;
//
//        let bounds = collectionView.bounds;
//        let width: CGFloat = (bounds.width-(10*3*1.5))/3;
//        size = CGSize(width: width, height: collectionView.bounds.height);
//
//        return size;
//    }
//}
