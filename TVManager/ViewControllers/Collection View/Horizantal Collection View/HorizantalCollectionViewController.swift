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
    var didSelectItemDelegate: DidSelectItem?

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
            cell.layoutIfNeeded()

        }
        cell.backgroundColor = .systemBlue
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let detailsViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
//        let home = HomeViewController()
//        didSelectItem = home
        didSelectItemDelegate?.item(indexPath)
//        detailsViewController.showDetailViewController(detailsViewController, sender: self)
//        detailsViewController.show(detailsViewController, sender: self)
//        self.storyboard?.instantiateViewController(withIdentifier: "idMyViewControllerName")
//        detailsViewController.present(detailsViewController, animated: false, completion: nil)
//        let viewController =
//        UIViewController.present(detailsViewController)
//        Instantiiate
    }
}

protocol DidSelectItem {
    func item(_ indexPath: IndexPath)
}
