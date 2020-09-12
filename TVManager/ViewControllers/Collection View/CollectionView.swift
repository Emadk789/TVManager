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
        let width: CGFloat = (bounds.width-(10*3*1.5))/3;
        size = CGSize(width: width, height: collectionView.bounds.height);
        
        return size;
    }
}
