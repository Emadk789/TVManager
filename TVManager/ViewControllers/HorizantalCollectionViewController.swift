//
//  HorizantalCollectionView.swift
//  TVManager
//
//  Created by Emad Albarnawi on 06/09/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit

class HorizantalCollectionViewController: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
//    var type: HorizantalCollectionViewDataSource.HorizantalCollectionViewType = .tv;
    var data:[UIImage?] = []
    //    var custom: customHorizantalCollectionViewDelegate?;
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let number = 4 >= HorizantalCollectionViewDataSource.posterImages.count ? 4 : HorizantalCollectionViewDataSource.posterImages.count;
//        let number2 = HorizantalCollectionViewDataSource.posterImages.count;
//        let number3 = HorizantalCollectionViewDataSource.imagesToLoade;
//        print("HorizantalCollectionViewController", type);
        let number4 = data.count;
        return number4;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HorizantalCollectionViewCell;
        cell.backgroundColor = .systemBlue;
        print(HorizantalCollectionViewDataSource.posterImages.count, indexPath.item);
//        cell.imageView.image = HorizantalCollectionViewDataSource.posterImages[indexPath.row];
        cell.imageView.image = data[indexPath.item];
        return cell;
    }
    
    
}

extension HorizantalCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGSize;
        //        size = horizantalCollectionView.frame;
        let bounds = collectionView.bounds;
        let width: CGFloat = (bounds.width-(10*3*1.5))/3;
        size = CGSize(width: width, height: collectionView.bounds.height);
        
        return size;
    }
}
