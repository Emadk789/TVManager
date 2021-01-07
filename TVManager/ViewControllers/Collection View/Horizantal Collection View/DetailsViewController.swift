//
//  DetailsViewController.swift
//  TVManager
//
//  Created by Emad Albarnawi on 04/01/2021.
//  Copyright © 2021 Emad Albarnawi. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    

    
}

//MARK:- UICollectionViewDelegate, UICollectionViewDataSource
extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! DetailsViewControllerCell
        cell.imageView.backgroundColor = .systemRed
        cell.backgroundColor = .systemBlue
        return cell
    }
    
    
}
// MARK:- DetailsViewControllerCell
class DetailsViewControllerCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
}

extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        return CGSize(width: screenWidth, height: screenHeight)
    }
}
