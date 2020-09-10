//
//  HorizantalCollectionView.swift
//  TVManager
//
//  Created by Emad Albarnawi on 06/09/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit

class HorizantalCollectionViewController: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var custom: customHorizantalCollectionViewDelegate?;
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let number = 4 >= HorizantalCollectionViewDataSource.posterImages.count ? 4 : HorizantalCollectionViewDataSource.posterImages.count;
        let number2 = HorizantalCollectionViewDataSource.posterImages.count;
        let number3 = HorizantalCollectionViewDataSource.imagesToLoade;
        return number3;
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        <#code#>
//    }
//    titleforheader
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HorizantalCollectionViewCell;
        cell.backgroundColor = .systemBlue;
//        if HorizantalCollectionViewDataSource.posterImages.count > indexPath.row {
//            guard let image = (HorizantalCollectionViewDataSource.posterImages[indexPath.row]) else { return cell }
//        print(HorizantalCollectionViewDataSource.currentSection)
//        if HorizantalCollectionViewDataSource.currentSection == 0 {
        print(HorizantalCollectionViewDataSource.posterImages.count, indexPath.row);
//        if HorizantalCollectionViewDataSource.posterImages.count <= indexPath.row {
            cell.imageView.image = HorizantalCollectionViewDataSource.posterImages[indexPath.row];
//        }
//            cell.imageView.image = HorizantalCollectionViewDataSource.posterImages[indexPath.row];
//        }
            
//        }
        
//        custom?.reloadeCollectionView();
//        print(custom);
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
