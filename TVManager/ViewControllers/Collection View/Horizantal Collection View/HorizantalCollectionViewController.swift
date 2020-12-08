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
        
        if let response = response {
            let mediaID = response.response.results[indexPath.item].id!
            cell.imageView.image = response.data[indexPath.item];
            cell.mediaID = mediaID
            cell.mediaType = response.mediaType
            print(response.response.results[indexPath.item].name, mediaID)
//            if Data.favoriteLists.favoriteTVList.contains(mediaID) {
//                print(Data.favoriteLists.favoriteTVList.contains(mediaID), Data.favoriteLists.favoriteTVList[indexPath.item], mediaID)
//                cell.favoriteButton.imageView?.image = UIImage(systemName: "heart.fill")
//            }
//            for id in Data.favoriteLists.favoriteTVList {
////                let itemID = mediaID
//                print(id, mediaID)
//                if mediaID == id {
//                    cell.favoriteButton.imageView?.isHidden = true
//                    cell.favoriteButton.imageView?.image = UIImage(systemName: "heart.fill")
//                }
//                else {
//                    cell.favoriteButton.imageView?.image = UIImage(systemName: "heart")
//                }
//
//            }
        }
        cell.backgroundColor = .systemBlue
        return cell;
    }
}
