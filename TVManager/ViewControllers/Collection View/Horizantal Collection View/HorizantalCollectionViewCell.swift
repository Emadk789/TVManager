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
            updateViews()
            
        }
    }
    var mediaType: TVClient.EndPoints.Kind = .movie;
    
    enum ListType: String {
        case favorite, watchlist
    }
    
    @IBAction func watchlistButtonClicked(_ sender: Any) {
        //Add to watchlist
        makePostDecodableRequest(listType: ListType.watchlist, add: true)
    }
    
    @IBAction func favoritButtonClicked(_ sender: Any) {
        let x = favoriteButton.currentImage
//        favoriteButton.currentImage?.isEqual(
//            switch self {
//
//            }<#Any?#>)
        switch favoriteButton.currentImage {
        case UIImage(systemName: "heart.fill"):
            //Remove from favoite
            makePostDecodableRequest(listType: ListType.favorite, add: true)
            
        case UIImage(systemName: "heart"):
            //Add to favoite
            makePostDecodableRequest(listType: ListType.favorite, add: false)
        default:
            break
        }
        
        
        
        
        
    }
    
    //MARK:- Helper(s)
    private func makePostDecodableRequest(listType: ListType, add: Bool){
        TVClient.shared.PostDecodableRequest(kind: mediaType, mediaID: mediaID, listType: listType, add: add) { (success, error) in
        }
    }
    
    override func prepareForReuse() {
        watchlistButton.imageView?.image = UIImage(systemName: "heart")
        favoriteButton.imageView?.image = UIImage(systemName: "heart")
    }
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        updateViews()
    }
    
    private func updateViews() {
        if Data.favoriteLists.favoriteTVList.contains(mediaID) || Data.favoriteLists.favoriteMovieList.contains(mediaID) {
            print("yes")
            favoriteButton.imageView?.image = UIImage(systemName: "heart.fill")
        }
        if Data.watchlistLists.watchlistTVList.contains(mediaID) || Data.watchlistLists.watchlistMovieList.contains(mediaID) {
            watchlistButton.imageView?.image = UIImage(systemName: "stopwatch.fill")
        }
    }
}
