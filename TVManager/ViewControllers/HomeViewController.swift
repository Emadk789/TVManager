//
//  HomeViewController.swift
//  TVManager
//
//  Created by Emad Albarnawi on 05/09/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, DidSelectItem {
    func item(_ indexPath: IndexPath, response: Response?, poster: UIImage?) {

        let detailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        detailsViewController.response = response
        detailsViewController.poster = poster
        self.navigationController?.pushViewController(detailsViewController, animated: true)

    }
    @IBOutlet weak var verticalCollectionView: UICollectionView!
    lazy var verticalCollectionViewController = VerticalCollectionViewController();
    
    @IBOutlet weak var searchButton: UIButton!
    
    var responses2: Responses2? {
        didSet {
            
            verticalCollectionViewController.responses = responses2;
            verticalCollectionView.reloadData();
        }
    }
    var mediaTypes: [TVClient.EndPoints.Kind] = [];
    var data: [[UIImage?]] = [] {
        didSet {
            verticalCollectionViewController.data = data;
        }
    }
    var didselectItem: HorizantalCollectionViewController?
    enum Kind: Int, CaseIterable {
        case PopularTV = 0, PopularMovie = 1;
    }
    enum ListType: CaseIterable {
        case favorite, watchlist
    }
    override func viewDidLoad() {
        super.viewDidLoad();
//        didselectItem?.didSelectItemDelegate = self
        getAccount {
            self.prepareDataLists {
                self.getPopularRequests()
            }
        }
        
        verticalCollectionView.delegate = verticalCollectionViewController;
        verticalCollectionView.dataSource = verticalCollectionViewController;
        
        verticalCollectionViewController.homeRef = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("I am in view will appear", Data.favoriteLists.favoriteTVList)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    private func getPopularRequests() {
        responses2 = Responses2(response2: [])
        for _ in 0..<Kind.allCases.count {
            responses2?.response2.append(nil)
        }
        let TVURL = TVClient.EndPoints.getPopular(.tv).stringURL;
        TVClient.shared.getDecodableRequest(url: TVURL, kind: .PopularTV, response: GetPopularResponse.self, completion: self.handelHomeResponses(response:kind:error:))
        
        let MovieURL = TVClient.EndPoints.getPopular(.movie).stringURL;
        TVClient.shared.getDecodableRequest(url: MovieURL, kind: .PopularMovie, response: GetPopularResponse.self, completion: self.handelHomeResponses(response:kind:error:))
    }
    @IBAction func searchButtonClicked(_ sender: Any) {
        searchButton.isHidden = !searchButton.isHidden;
        let searchViewController = storyboard?.instantiateViewController(identifier: "SearchViewController") as! SearchViewController
        searchViewController.searchButtonDelegate = self;
        present(searchViewController, animated: true);
    }
    private func handelHomeResponses(response: GetPopularResponse?, kind: Kind, error: Error?) {
        if error != nil { return }
        
        if let response = response {
            
            responses2?.response2[kind.rawValue] = response
            
            prepareData(kind: kind, count: response.results.count);
            callDownloadeImages(kind: kind, results: response.results);
        }
    }
    func handelDownloadeHomeImages(image: UIImage?, error: Error?, kind: Kind) {
        if let index = data[kind.rawValue].firstIndex(of: nil) {
            data[kind.rawValue][index] = image;
            responses2?.data[kind.rawValue][index] = image
        }
    }
    // MARK: - Helpers
    private func prepareData(kind: Kind, count: Int) {
        var index = 0;
        let tempArray: [UIImage?] = [];
        data.append(tempArray);
        while index < count {
            data[kind.rawValue].append(nil)
            index+=1;
        }
        switch kind {
        case .PopularMovie:
            mediaTypes.append(.movie);
        case .PopularTV:
            mediaTypes.append(.tv);
        }
        responses2?.mediaTypes = mediaTypes
        responses2?.data = data
        
    }
    private func callDownloadeImages(kind: Kind, results: [Result]) {
        for result in results {
            // TODO: Handel nil posterPath.
            TVClient.shared.downloadeHomeImages(path: result.posterPath!, Kind: kind, completion: self.handelDownloadeHomeImages(image:error:kind:))
        }
    }
}
extension HomeViewController: SearchButton {
    func toggelSearchButton() {
        searchButton.isHidden = !searchButton.isHidden;
    }
}

protocol SearchButton {
    func toggelSearchButton();
}

// MARK:- Get Account Info
extension HomeViewController {
    private func getAccount(completion: @escaping () -> Void) {
        let accountURL = TVClient.EndPoints.account.stringURL
        
        TVClient.shared.getDecodableRequest(url: accountURL, response: GetDetailsResponse.self) { (response, error) in
            TVClient.Auth.setAccountID(id: "\(response!.id)")
            completion()
        }
    }
    
}

// MARK:- DataLists
extension HomeViewController {
    private func prepareDataLists(completion: @escaping (() -> Void)) {
        // Call getDataLists with all the cases of ListType
        var count: Int = 0
        ListType.allCases.forEach{
            getDataLists(listType: $0) {
                if count == 4 {
                    completion()
                }
                count += 1
            }
        }
    }
    private func getDataLists(listType: ListType, completion: @escaping (() -> Void)) {
        var url: URL
        switch listType {
        case .favorite:
            url = TVClient.EndPoints.getFavorite(.tv).stringURL;
            print(url)
            makeDecodableRequest(url: url) { results in
                for i in 0..<results.count {
                    Data.favoriteLists.favoriteTVList.append(results[i].id!)
                    completion()
                }
            }
            
            url = TVClient.EndPoints.getFavorite(.movie).stringURL;
            makeDecodableRequest(url: url) { results in
                for i in 0..<results.count {
                    Data.favoriteLists.favoriteMovieList.append(results[i].id!)
                    completion()
                }
            }
        case .watchlist:
            url = TVClient.EndPoints.getWatchlist(.tv).stringURL;
            makeDecodableRequest(url: url) { results in
                for i in 0..<results.count {
                    Data.watchlistLists.watchlistTVList.append(results[i].id!)
                    completion()
                }
            }
            
            url = TVClient.EndPoints.getWatchlist(.movie).stringURL;
            makeDecodableRequest(url: url) { results in
                for i in 0..<results.count {
                    Data.watchlistLists.watchlistMovieList.append(results[i].id!)
                    completion()
                }
            }
        }
        
    }
    
    private func makeDecodableRequest(url: URL, completion:  @escaping ([Result]) -> Void) {
        TVClient.shared.getDecodableRequest(url: url, response: GetPopularResponse.self) { (response, error) in
            if let response = response {
                completion(response.results)
            }
        }
    }
}
