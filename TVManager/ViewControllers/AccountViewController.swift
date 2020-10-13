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
    var TVData: [[UIImage?]] = []
    var moviesData: [[UIImage?]] = []
    let tempArray: [UIImage?] = [];
//        let tempArray: [UIImage?] = [];

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
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
//        TVData.append(tempArray);
//        moviesData.append(tempArray);
    }
    @IBAction func segmentViewClicked(_ sender: Any) {
        let index = segmentView.selectedSegmentIndex;
        data = []
        switch index {
        case 0:
            if !TVData[0].isEmpty {
                collectionView.reloadData();
                return;
            }
            var url = Requests.favorit(kind: .tv).url;
            makeRequest(url: url, responseType: GetPopularResponse.self, handler: .favorit());
            url = Requests.watchlist(kind: .tv).url;
            makeRequest(url: url, responseType: GetPopularResponse.self, handler: .watchlist());
        case 1:
            if !moviesData[0].isEmpty {
                collectionView.reloadData();
                return;
            }
            var url = Requests.favorit(kind: .movie).url;
            makeRequest(url: url, responseType: GetPopularResponse.self, handler: .favorit());
            url = Requests.watchlist(kind: .movie).url;
            makeRequest(url: url, responseType: GetPopularResponse.self, handler: .watchlist());
        default:
            break
        }
    }
    private func updateUI() {
        // TODO: You can store the username in UserDefaults!
        userNameLabel.text = "Hi, \(account.username)";
    }

    private func downloadeImages(of type: DownloadType, response: GetPopularResponse?) {
        
        prepareData(kind: type, count: response?.results.count ?? 0);
        for response in favoritResponse?.results ?? [] {
            TVClient.shared.downloadeImages(path: response.posterPath!) { (image, error) in
                if let index = self.data[type.intValue].firstIndex(of: nil) {
                    self.data[type.intValue][index] = image;
                }
                
                switch self.segmentView.selectedSegmentIndex {
                case 0:
//                    self.TVData[type.intValue].append(image);
                    self.TVData = self.data;
                case 1:
//                    self.moviesData[type.intValue].append(image);
                    self.moviesData = self.data;
                default:
                    break;
                }
                
            }
        }
    }
    private func prepareData2(kind: DownloadType, count: Int) {
        var index = 0;
        let tempArray: [UIImage?] = [];
//        repeat {
//            data.append(tempArray);
//        } while data.count <= kind.intValue
//        var sum = 0;
//        repeat {
//            sum = 0;
//            moviesData.append(tempArray);
//            TVData.append(tempArray);
//            sum = moviesData.count + TVData.count;
//        } while sum <= kind.intValue
        moviesData.append(tempArray);
        TVData.append(tempArray);
        while index < count {
            data[kind.intValue].append(nil)
            index+=1;
        }
    }
    // MARK: - Helpers
    private func prepareData(kind: DownloadType, count: Int) {
        var index = 0;
        let tempArray: [UIImage?] = [];
////        let tempArray: [UIImage?] = [];
//        self.TVData.append(tempArray);
//        self.moviesData.append(tempArray);
        repeat {
            data.append(tempArray);
            if data.count > TVData.count || data.count > moviesData.count {
                switch segmentView.selectedSegmentIndex {
                case 0:
                    TVData.append(tempArray);
                case 1:
                    moviesData.append(tempArray);
                default:
                    break;
                }
                
                
            }
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
        self.updateUI();
    }
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
//MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension AccountViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        data.count;
        var numberOfSections = 0;
        switch segmentView.selectedSegmentIndex {
        case 0:
            numberOfSections = TVData.count;
        case 1:
            numberOfSections = moviesData.count;
        default:
            break
        }
        if numberOfSections == 0 {
            numberOfSections = data.count;
        }
        return numberOfSections;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AccountViewControllerCell;
        cell.backgroundColor = .systemTeal;
        cell.cellNumber = indexPath.item; //???
//        cell.data = data[indexPath.section];
        
        var myData: [[UIImage?]] = [];
        if TVData[indexPath.section].isEmpty || moviesData[indexPath.section].isEmpty {
            myData = data;
        }
//        myData = TVData.isEmpty && moviesData.isEmpty ? self.data : D
        switch segmentView.selectedSegmentIndex {
        case 0:
            if !TVData[indexPath.section].isEmpty {
                myData = TVData;
            }
            
        case 1:
            if !moviesData[indexPath.section].isEmpty {
                myData = moviesData;
            }
        default:
            break
        }
        cell.data = myData[indexPath.section];
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













