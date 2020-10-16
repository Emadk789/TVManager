//
//  AccountHorizantalCollectionViewCell.swift
//  TVManager
//
//  Created by Emad Albarnawi on 30/09/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit

class AccountHorizantalCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var watchlistButton: UIButton!
    @IBOutlet weak var favoritButton: UIButton!
    
    var cellNumber = Int();
    
    override func prepareForReuse() {
        switch cellNumber {
        case 0:
            watchlistButton.imageView?.image = UIImage(systemName: "stopwatch")
        case 1:
            favoritButton.imageView?.image = UIImage(systemName: "heart")
        default:
            break;
        }
        watchlistButton.addBoarder(with: .black);
        favoritButton.addBoarder(with: .black);
    }
    
//    let favorit
//    enum accountStaticData {
//        enum favorit {
//            switch Kind {
//
//            }
//        }
//        enum watchlist {
//
//        }
//    }
    @IBAction func watchlistButtonClicked(_ sender: Any) {
        //TODO: Remove from watchlist!
    }
    
    @IBAction func favoritButtonClicked(_ sender: Any) {
        //TODO: Remove from favoritlist
    }
    
    
}


