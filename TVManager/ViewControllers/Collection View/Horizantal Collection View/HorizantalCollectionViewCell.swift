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
    
    enum ListType: String {
        case favorite, watchlist
    }
    
    @IBAction func watchlistButtonClicked(_ sender: Any) {
//        TVClient.shared.PostDecodableRequest(kind: mediaType, mediaID: mediaID) { (success, error) in
//            print("sucess", success, "and", error);
//            let favorit = ListType.favorite.rawValue
//        }
        makePostDecodableRequest(listType: ListType.watchlist)
    }
    
    @IBAction func favoritButtonClicked(_ sender: Any) {
        makePostDecodableRequest(listType: ListType.favorite)
//        TVClient.shared.PostDecodableRequest(kind: mediaType, mediaID: mediaID) { (success, error) in
//            print("sucess", success, "and", error);
//        }
    }
    
    //MARK:- Helper(s)
    private func makePostDecodableRequest(listType: ListType){
        TVClient.shared.PostDecodableRequest(kind: mediaType, mediaID: mediaID, listType: listType) { (success, error) in
            print("sucess", success, "and", error);
        }
    }
}
