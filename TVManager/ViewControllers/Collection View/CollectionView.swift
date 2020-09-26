//
//  CollectionView.swift
//  TVManager
//
//  Created by Emad Albarnawi on 12/09/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit

class CollectionView: NSObject {
    
}
extension CollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGSize;

        let bounds = collectionView.bounds;
        let minSpacingForLine: CGFloat = 10;
        let numberOfCells: CGFloat = 3;
        let constant: CGFloat = 1.5;
        let width: CGFloat = (bounds.width-(minSpacingForLine*numberOfCells*constant))/numberOfCells;
        size = CGSize(width: width, height: collectionView.bounds.height);
        
        return size;
    }
}
