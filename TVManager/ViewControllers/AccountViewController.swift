//
//  AccountViewController.swift
//  TVManager
//
//  Created by Emad Albarnawi on 17/09/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit;


class AccountViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var segmentView: UISegmentedControl!
//    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    var account: GetDetailsResponse!;
    var createdLists: GetCreatedListsResponse!;
    var favoritResponse: GetPopularResponse? = nil;
    var watchlistResponse: GetPopularResponse? = nil;
    //TODO: Then make the finel look like HomeViewController.
    //TODO: Then generlize the two files and reues the same methods.
    //TODO: Have two different datasources for the .tv and .movie kinds
    var data: [[UIImage?]] = [] {
        didSet {
            collectionView.reloadData();
        }
    }
    enum Requests {
        case account,
             createdLists(account: GetDetailsResponse? = nil),
             favorit(kind: TVClient.EndPoints.Kind? = nil),
             watchlist(kind: TVClient.EndPoints.Kind? = nil);
        
        var url: URL {
            
            switch self {
            case .account:
                return TVClient.EndPoints.account.stringURL;
            case .createdLists(let account):
                return TVClient.EndPoints.getCreatedLists(accountID: "\(account!.id)").stringURL;
            case .favorit(let kind):
                return TVClient.EndPoints.getFavorite(kind!).stringURL;
            case .watchlist(let kind):
                return TVClient.EndPoints.getWatchlist(kind!).stringURL;
            }
        }
    }
    enum DownloadType {
        case favorit, watchlist;
        
        var stringValue: String {
            switch self {
            case .favorit:
                return "Favorit";
            case .watchlist:
                return "Watchlist";
            }
        }
        var intValue: Int {
            switch self {
            case .favorit:
                return 0;
            case .watchlist:
                return 1;
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self;
        collectionView.dataSource = self;
        makeRequest(url: Requests.account.url, responseType: GetDetailsResponse.self, handler: .account);
//        getAccount();
        
    }
    @IBAction func segmentViewClicked(_ sender: Any) {
        let index = segmentView.selectedSegmentIndex;
        data = []
        switch index {
        case 0:
//            data = []
            var url = Requests.favorit(kind: .tv).url;
            makeRequest(url: url, responseType: GetPopularResponse.self, handler: .favorit());
            url = Requests.watchlist(kind: .tv).url;
            makeRequest(url: url, responseType: GetPopularResponse.self, handler: .watchlist());
//            self.getFavorit(kind: .tv);
//            self.getWatchlist(kind: .tv);
        case 1:
//            data.removeAll()
            var url = Requests.favorit(kind: .movie).url;
            makeRequest(url: url, responseType: GetPopularResponse.self, handler: .favorit());
            url = Requests.watchlist(kind: .movie).url;
            makeRequest(url: url, responseType: GetPopularResponse.self, handler: .watchlist());
//            self.getFavorit(kind: .movie);
//            self.getWatchlist(kind: .movie);
        default:
            break
        }
//        let x = (sender as! UISegmentedControl).selectedSegmentIndex;
    }
//    func getAccount() {
//        let url = TVClient.EndPoints.account.stringURL;
//        TVClient.shared.getDecodableRequest(url: Requests.account.url, response: GetDetailsResponse.self) { (response, error) in
//
//            // TODO: Handel error and check the response!
//            self.account = response;
//            TVClient.Auth.setAccountID(id: "\(self.account.id)");
//            self.getFavorit(kind: .tv);
//            self.getWatchlist(kind: .tv)
//            self.getCreatedLists();
//            self.updateUI();
//
//        }
//    }
    private func updateUI() {
        // TODO: You can store the username in UserDefaults!
        userNameLabel.text = "Hi, \(account.username)";
    }
//    private func getCreatedLists() {
//        let url = TVClient.EndPoints.getCreatedLists(accountID: "\(account.id)").stringURL;
//        TVClient.shared.getDecodableRequest(url: Requests.createdLists(account: account).url, response: GetCreatedListsResponse.self) { (response, error) in
//            // TODO: Handel error and check the response!
//            self.createdLists = response;
//        }
//    }
//    private func getFavorit(kind: TVClient.EndPoints.Kind) {
//        let url = TVClient.EndPoints.getFavorite(kind).stringURL;
//
//        TVClient.shared.getDecodableRequest(url: Requests.favorit(kind: kind).url, response: GetPopularResponse.self) { (response, error) in
////            response?.results[0].
//            self.favoritResponse = response;
//            self.downloadeImages(of: .favorit, response: response);
//
//        }
//    }
//    private func getWatchlist(kind: TVClient.EndPoints.Kind) {
//        let url = TVClient.EndPoints.getWatchlist(kind).stringURL;
//
//        TVClient.shared.getDecodableRequest(url: Requests.watchlist(kind: kind).url, response: GetPopularResponse.self) { (response, error) in
////            response?.results[0].
//            self.watchlistResponse = response;
//            self.downloadeImages(of: .watchlist, response: response);
//
//        }
//    }
    private func downloadeImages(of type: DownloadType, response: GetPopularResponse?) {
        
        prepareData(kind: type, count: response?.results.count ?? 0);
        for response in favoritResponse?.results ?? [] {
            TVClient.shared.downloadeImages(path: response.posterPath!) { (image, error) in
                if let index = self.data[type.intValue].firstIndex(of: nil) {
                    self.data[type.intValue][index] = image;
                }
                
            }
        }
        
//        var images: [UIImage?] = [];
//        switch type {
//        case .favorit:
////            self.data.append([]);
//            prepareData(kind: type, count: favoritResponse?.results.count ?? 0);
//            for response in favoritResponse?.results ?? [] {
//                TVClient.shared.downloadeImages(path: response.posterPath!) { (image, error) in
//                    if let index = self.data[type.intValue].firstIndex(of: nil) {
//                        self.data[type.intValue][index] = image;
//                    }
////                    self.data[0].append(image);
////                    self.data.append(image);
////                    self.collectionView.reloadData();
//                }
//            }
//        case .watchlist:
////            self.data2.append([nil]);
//            self.data.append([]);
//            for response in watchlistResponse?.results ?? [] {
////                self.data2[1] = [];
//                TVClient.shared.downloadeImages(path: response.posterPath!) { (image, error) in
//                    self.data[1].append(image);
////                    self.data.append(image);
////                    self.collectionView.reloadData();
//                }
//            }
//
//        }
    }
    // MARK: - Helpers
    private func prepareData(kind: DownloadType, count: Int) {
        var index = 0;
        let tempArray: [UIImage?] = [];
        repeat {
            data.append(tempArray);
        } while data.count <= kind.intValue

        while index < count {
            data[kind.intValue].append(nil)
            index+=1;
        }
    }
    private func makeRequest<responseType: Decodable>(url: URL, responseType: responseType.Type, handler: Requests) {
        TVClient.shared.getDecodableRequest(url: url, response: responseType.self) { (response, error) in
            switch handler {
            case .account:
                self.handelAccountResponse(response: response);
            case .createdLists:
                self.handelCreatedListsResponse(response: response);
            case .favorit:
                self.handelFavoritResponse(response: response);
            case .watchlist:
                self.handelWatchlistResponse(response: response);
            }
        }
    }
    private func handelAccountResponse<response: Decodable>(response: response) {
        
        self.account = (response as! GetDetailsResponse);
        TVClient.Auth.setAccountID(id: "\(self.account.id)");
        
        var url = Requests.favorit(kind: .tv).url;
        makeRequest(url: url, responseType: GetPopularResponse.self, handler: .favorit());
        
        url = Requests.watchlist(kind: .tv).url;
        makeRequest(url: url, responseType: GetPopularResponse.self, handler: .watchlist());
        
        url = Requests.createdLists(account: account).url;
        makeRequest(url: url, responseType: GetCreatedListsResponse.self, handler: .createdLists());
//        self.getFavorit(kind: .tv);
//        self.getWatchlist(kind: .tv)
//        self.getCreatedLists();
        self.updateUI();
    }
//    private func makePostAccountRequests<responseType: Decodable>(url: URL, responseType: responseType.Type, handler: Requests) {
//        makeRequest(url: url, responseType: responseType, handler: handler);
//    }
    private func handelCreatedListsResponse<response: Decodable>(response: response) {
        self.createdLists = response as? GetCreatedListsResponse;
    }
    private func handelFavoritResponse<response: Decodable>(response: response) {
        self.favoritResponse = response as? GetPopularResponse;
        self.downloadeImages(of: .favorit, response: response as? GetPopularResponse);
    }
    private func handelWatchlistResponse<response: Decodable>(response: response) {
        self.watchlistResponse = response as? GetPopularResponse;
        self.downloadeImages(of: .watchlist, response: response as? GetPopularResponse);
    }

}

extension AccountViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        data.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        favoritResponse?.results.count ?? 5;
//        5
//        data2[section].count;
        1
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? CollectionViewHeader{
            var header = "";
            switch indexPath.section {
            case 0:
                header = DownloadType.favorit.stringValue;
            case 1:
                header = DownloadType.watchlist.stringValue;
            default:
                break;
            }
            sectionHeader.sectionHeader.text = header;
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AccountViewControllerCell;
        cell.backgroundColor = .systemTeal;
//        cell.favoritResponse = self.favoritResponse;
        cell.cellNumber = indexPath.item; //???
        cell.data = data[indexPath.section];
        
//        switch indexPath.section {
//        case 0:
//            cell.accountHorizantalCollectionViewLabel.text = "Favorit";
//        default:
//            cell.accountHorizantalCollectionViewLabel.text = "Watchlist";
//        }
        
        return cell;
    }
    
    
}
extension AccountViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds;
//        let width: CGFloat = (bounds.width-(10*3*1.5))/3;
        let width: CGFloat = bounds.width;
        let size = CGSize(width: width, height: 250)
        return size;
    }
}













