//
//  VerticalCollectionViewController.swift
//  TVManager
//
//  Created by Emad Albarnawi on 06/09/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit

class VerticalCollectionViewController: CollectionView, UICollectionViewDataSource {
    
    var movieData: [[UIImage?]] = [];
    var tvData: [[UIImage?]] = [];
    var data: [[UIImage?]] = [];
    var responses: Responses?
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //
        //        3
//        HorizantalCollectionViewDataSource.data.count;
//        data.count;
        (responses?.data.count) ?? 0;
        
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
//            cell.data = HorizantalCollectionViewDataSource.data[indexPath.section];
//            cell.data = data[indexPath.section];
//            let x = responses?.responsex
            let result = Result(posterPath: nil, popularity: nil, id: nil, name: nil, title: nil, originalName: nil, overview: nil);
            let response = GetPopularResponse(page: 10, totalResults: 1, totalPages: 1, results: [result])
            cell.response = Response(response: response);
            
            cell.response?.response = responses!.response;
            cell.response?.data = (responses?.data[indexPath.section])!;
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
