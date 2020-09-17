//
//  AccountViewController.swift
//  TVManager
//
//  Created by Emad Albarnawi on 17/09/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    var account: GetDetailsResponse!;
    var createdLists: GetCreatedListsResponse!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAccout();
    }
    
    private func getAccout() {
        let url = TVClient.EndPoints.account.stringURL;
        TVClient.shared.getDecodableRequest(url: url, imageType: .movie(image: nil), response: GetDetailsResponse.self) { (response, type, error) in
            
            // TODO: Handel error and check the response!
            self.account = response;
            TVClient.Auth.setAccountID(id: "\(self.account.id)");
            self.getFavorit(kind: .movie);
            self.getCreatedLists();
            self.updateUI();
            
        }
    }
    private func updateUI() {
        // TODO: You can store the username in UserDefaults!
        userNameLabel.text = "Hi, \(account.username)";
    }
    private func getCreatedLists() {
        let url = TVClient.EndPoints.getCreatedLists(accountID: "\(account.id)").stringURL;
        TVClient.shared.getDecodableRequest(url: url, imageType: .movie(image: nil), response: GetCreatedListsResponse.self) { (response, type, error) in
            // TODO: Handel error and check the response!
            self.createdLists = response;
        }
    }
    private func getFavorit(kind: TVClient.EndPoints.Kind) {
        let url = TVClient.EndPoints.getFavorite(kind).stringURL;
        
        TVClient.shared.getDecodableRequest(url: url, imageType: .movie(image: nil), response: GetPopularResponse.self) { (response, type, error) in
            //TODO: set up the collection view based on the response returned!
            //
        }
    }

}
