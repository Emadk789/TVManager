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
    var favoritResponse: GetPopularResponse? = nil {
        didSet {
            collectionView.reloadData();
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self;
        collectionView.dataSource = self;
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
//            response?.results[0].
            self.favoritResponse = response;
            //TODO: set up the collection view based on the response returned!
            //
        }
    }

}

extension AccountViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favoritResponse?.results.count ?? 5;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath);
        switch indexPath.section {
        case 0:
            cell.backgroundColor = .systemPink;
        case 1:
            cell.backgroundColor = .systemBlue;
        case 2:
            cell.backgroundColor = .systemGray3;
        default:
            cell.backgroundColor = .systemGray;
        }
//        cell.backgroundColor = .systemPink;
        return cell;
    }
    
    
}
extension AccountViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds;
        let width: CGFloat = (bounds.width-(10*3*1.5))/3;
        let size = CGSize(width: width, height: 200)
        return size;
    }
}













