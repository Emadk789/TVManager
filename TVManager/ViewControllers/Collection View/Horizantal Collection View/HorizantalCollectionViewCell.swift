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
    @IBOutlet weak var watchlistButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
//    var mediaID = 0;
    var mediaID = 0 {
        didSet {
            if Data.favoriteLists.favoriteTVList.contains(mediaID) || Data.favoriteLists.favoriteMovieList.contains(mediaID) {
                favoriteButton.imageView?.image = UIImage(systemName: "heart.fill")
            }
            
        }
    }
    var mediaType: TVClient.EndPoints.Kind = .movie;
    
    enum ListType: String {
        case favorite, watchlist
    }
    
    @IBAction func watchlistButtonClicked(_ sender: Any) {
        makePostDecodableRequest(listType: ListType.watchlist)
    }
    
    @IBAction func favoritButtonClicked(_ sender: Any) {
        makePostDecodableRequest(listType: ListType.favorite)
    }
    
    //MARK:- Helper(s)
    private func makePostDecodableRequest(listType: ListType){
        TVClient.shared.PostDecodableRequest(kind: mediaType, mediaID: mediaID, listType: listType) { (success, error) in
        }
    }
}
