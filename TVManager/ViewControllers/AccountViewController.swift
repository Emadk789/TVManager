//
//  AccountViewController.swift
//  TVManager
//
//  Created by Emad Albarnawi on 17/09/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit;

//protocol AccountViewControllerDelegate {
//    func getAccount();
//}

class AccountViewController: UIViewController {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var segmentView: UISegmentedControl!
//    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    var account: GetDetailsResponse!;
    var createdLists: GetCreatedListsResponse!;
    var favoritResponse: GetPopularResponse? = nil;
    var watchlistResponse: GetPopularResponse? = nil;
//    var favoritResponse: GetPopularResponse? = nil {
//        didSet {
//            collectionView.reloadData();
//        }
//    }
    var data2: [[UIImage?]] = [] {
        didSet {
            collectionView.reloadData();
        }
    }
    var data: [UIImage?] = [] {
        didSet {
            collectionView.reloadData();
        }
    }
    enum DownloadType {
        case favorit, whatchlist;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self;
        collectionView.dataSource = self;
        // TODO: Implement delegate between Home and Account VC's
        // All initial request should start form Home VC!!!
        getAccount();
        
    }
    @IBAction func segmentViewClicked(_ sender: Any) {
        let index = segmentView.selectedSegmentIndex;
        switch index {
        case 0:
            data2 = [];
            self.getFavorit(kind: .tv);
            self.getWatchlist(kind: .tv);
        case 1:
            data2 = [];
            self.getFavorit(kind: .movie);
            self.getWatchlist(kind: .movie);
        default:
            break
        }
//        let x = (sender as! UISegmentedControl).selectedSegmentIndex;
    }
//    func getAccount() {
//        let url = TVClient.EndPoints.account.stringURL;
//        TVClient.shared.getDecodableRequest(url: url, response: GetDetailsResponse.self) { (response, type, error) in
//
//            // TODO: Handel error and check the response!
//            self.account = response;
//            TVClient.Auth.setAccountID(id: "\(self.account.id)");
//            self.getFavorit(kind: .movie);
//            self.getCreatedLists();
//            self.updateUI();
//
//        }
//    }
    func getAccount() {
        let url = TVClient.EndPoints.account.stringURL;
        TVClient.shared.getDecodableRequest(url: url, response: GetDetailsResponse.self) { (response, type, error) in
            
            // TODO: Handel error and check the response!
            self.account = response;
            TVClient.Auth.setAccountID(id: "\(self.account.id)");
            self.getFavorit(kind: .tv);
            self.getWatchlist(kind: .tv)
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
        TVClient.shared.getDecodableRequest(url: url, response: GetCreatedListsResponse.self) { (response, type, error) in
            // TODO: Handel error and check the response!
            self.createdLists = response;
        }
    }
    private func getFavorit(kind: TVClient.EndPoints.Kind) {
        let url = TVClient.EndPoints.getFavorite(kind).stringURL;
        
        TVClient.shared.getDecodableRequest(url: url, response: GetPopularResponse.self) { (response, type, error) in
//            response?.results[0].
            self.favoritResponse = response;
            self.downloadeImages(of: .favorit);
            
            //TODO: set up the collection view based on the response returned!
            //
        }
    }
    private func getWatchlist(kind: TVClient.EndPoints.Kind) {
        let url = TVClient.EndPoints.getWatchlist(kind).stringURL;
        
        TVClient.shared.getDecodableRequest(url: url, response: GetPopularResponse.self) { (response, type, error) in
//            response?.results[0].
            self.watchlistResponse = response;
            self.downloadeImages(of: .whatchlist);
            
            //TODO: set up the collection view based on the response returned!
            //
        }
    }
    private func downloadeImages(of type: DownloadType) {
//        var images: [UIImage?] = [];
        switch type {
        case .favorit:
            self.data2.append([]);
            for response in favoritResponse?.results ?? [] {
                TVClient.shared.downloadeImages(path: response.posterPath!) { (image, error, type) in
                    self.data2[0].append(image);
//                    self.data.append(image);
//                    self.collectionView.reloadData();
                }
            }
        case .whatchlist:
//            self.data2.append([nil]);
            self.data2.append([]);
            for response in watchlistResponse?.results ?? [] {
//                self.data2[1] = [];
                TVClient.shared.downloadeImages(path: response.posterPath!) { (image, error, type) in
                    self.data2[1].append(image);
//                    self.data.append(image);
//                    self.collectionView.reloadData();
                }
            }
            
        }
    }

}

extension AccountViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        data2.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        favoritResponse?.results.count ?? 5;
//        5
//        data2[section].count;
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AccountViewControllerCell;
        cell.backgroundColor = .systemTeal;
//        cell.favoritResponse = self.favoritResponse;
        cell.cellNumber = indexPath.item; //???
        cell.data = data2[indexPath.section];
        
        switch indexPath.section {
        case 0:
            cell.accountHorizantalCollectionViewLabel.text = "Favorit";
        default:
            cell.accountHorizantalCollectionViewLabel.text = "Watchlist";
        }
        
//        guard data != [] else { return cell }
//        cell.data = data;
//        cell.accountHorizantalCollectionViewLabel.text = "Favorit";
//        cell.data = HorizantalCollectionViewDataSource.data[indexPath.section];
//        cell.data = data;
//        switch indexPath.section {
//        case 0:
//            cell.backgroundColor = .systemPink;
//        case 1:
//            cell.backgroundColor = .systemBlue;
//        case 2:
//            cell.backgroundColor = .systemGray3;
//        default:
//            cell.backgroundColor = .systemGray;
//        }
//        cell.backgroundColor = .systemPink;
        return cell;
    }
    
    
}
extension AccountViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds;
//        let width: CGFloat = (bounds.width-(10*3*1.5))/3;
        let width: CGFloat = bounds.width;
        let size = CGSize(width: width, height: 200)
        return size;
    }
}













