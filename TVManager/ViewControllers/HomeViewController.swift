//
//  HomeViewController.swift
//  TVManager
//
//  Created by Emad Albarnawi on 05/09/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var verticalCollectionView: UICollectionView!
    lazy var verticalCollectionViewController = VerticalCollectionViewController();
    
    @IBOutlet weak var searchButton: UIButton!
    
    //TODO: Send the request with the image data
    
    var responses: Responses? {
        didSet {
            
            verticalCollectionViewController.responses = responses;
            verticalCollectionView.reloadData();
        }
    };
    
    var data: [[UIImage?]] = [] {
        didSet {
            verticalCollectionViewController.data = data;
//            verticalCollectionView.reloadData();
        }
    };
    enum Kind: Int {
        case PopularTV = 0, PopularMovie = 1;
    }
    
    
//    var accountViewControllerDelegate: AccountViewControllerDelegate!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        let TVURL = TVClient.EndPoints.getPopular(.tv).stringURL;
        TVClient.shared.getDecodableRequest(url: TVURL, kind: .PopularTV, response: GetPopularResponse.self, completion: self.handelHomeResponses(response:kind:error:))
        
        let MovieURL = TVClient.EndPoints.getPopular(.movie).stringURL;
        TVClient.shared.getDecodableRequest(url: MovieURL, kind: .PopularMovie, response: GetPopularResponse.self, completion: self.handelHomeResponses(response:kind:error:))

        verticalCollectionView.delegate = verticalCollectionViewController;
        verticalCollectionView.dataSource = verticalCollectionViewController;
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
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
            responses = Responses(response: response);
            prepareData(kind: kind, count: response.results.count);
            callDownloadeImages(kind: kind, results: response.results);
        }
    }
    func handelDownloadeHomeImages(image: UIImage?, error: Error?, kind: Kind) {
        if let index = data[kind.rawValue].firstIndex(of: nil) {
            data[kind.rawValue][index] = image;
            responses?.data[kind.rawValue][index] = image;
            
        }
    }
    // MARK: - Helpers
    private func prepareData(kind: Kind, count: Int) {
        var index = 0;
        let tempArray: [UIImage?] = [];
        data.append(tempArray);
        responses?.data.append(tempArray);
            while index < count {
                data[kind.rawValue].append(nil)
//                responses?.data[kind.rawValue].append(nil);
                index+=1;
            }
        responses?.data = data;
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
