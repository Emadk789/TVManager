//
//  HorizantalCollectionViewCell.swift
//  TVManager
//
//  Created by Emad Albarnawi on 08/09/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit

class HorizantalCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    var mediaID = 0;
    var mediaType: TVClient.EndPoints.Kind = .movie;
    
    @IBAction func watchlistButtonClicked(_ sender: Any) {
        //TODO: Add from watchlist!
    }
    
    @IBAction func favoritButtonClicked(_ sender: Any) {
        //TODO: Add from favoritlist
    }
}
