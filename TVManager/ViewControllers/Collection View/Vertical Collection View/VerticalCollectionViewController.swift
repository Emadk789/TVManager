//
//  VerticalCollectionViewController.swift
//  TVManager
//
//  Created by Emad Albarnawi on 06/09/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit

class VerticalCollectionViewController: CollectionView, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //
        //        3
        HorizantalCollectionViewDataSource.data.count;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        4
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? CollectionViewHeader{
            var header = "Popular";
            switch indexPath.section {
            case 0:
                header += " TV Shows";
            case 1:
                header += " Movies"
            default:
                break;
            }
            sectionHeader.sectionHeader.text = header;
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell;
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? VerticalCollectionViewCell {
//            cell.backgroundColor = .darkGray;
            cell.data = HorizantalCollectionViewDataSource.data[indexPath.section];
            return cell;
        }
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath);
        cell.backgroundColor = .systemRed;
        return cell;
    }
    
}

extension VerticalCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds;
        let size: CGSize;
        
        size = CGSize(width: bounds.width, height: 250);
        
        return size;
    }
}
