//
//  HomeViewController.swift
//  TVManager
//
//  Created by Emad Albarnawi on 05/09/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var VerticalCollectionView: UICollectionView!
    lazy var verticalCollectionViewController = VerticalCollectionViewController();
    
    @IBOutlet weak var searchButton: UIButton!
    
//    var accountViewControllerDelegate: AccountViewControllerDelegate!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // TODO: Add an escaping closure to know when the finishes and then start downloading the images and reloade the vViewController
        let TVURL = TVClient.EndPoints.getPopular(.tv).stringURL;
        TVClient.shared.getDecodableRequest(url: TVURL, imageType: .tv(image: nil), response: GetPopularResponse.self, completion: self.handelGetPopularTVShowsResponse(response:imageType:error:))
        let MovieURL = TVClient.EndPoints.getPopular(.movie).stringURL;
        TVClient.shared.getDecodableRequest(url: MovieURL, imageType: .movie(image: nil), response: GetPopularResponse.self, completion: self.handelGetPopularTVShowsResponse(response:imageType:error:))

        VerticalCollectionView.delegate = verticalCollectionViewController;
        VerticalCollectionView.dataSource = verticalCollectionViewController;
        
//        accountViewControllerDelegate.getAccount();
        
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
    
    func handelGetPopularTVShowsResponse(response: GetPopularResponse?, imageType: HorizantalCollectionViewDataSource.HorizantalCollectionViewType, error: Error?) {
        if error != nil { return }
        if let response = response {
//            response.
            HorizantalCollectionViewDataSource.imagesToLoade = response.results.count;
            VerticalCollectionView.reloadData();

            let tempArray: [UIImage?] = [];
            HorizantalCollectionViewDataSource.data.append(tempArray);
            
            for result in response.results {
                let x = HorizantalCollectionViewDataSource.data.endIndex;
                HorizantalCollectionViewDataSource.data[HorizantalCollectionViewDataSource.data.endIndex - 1].append(nil);
//                HorizantalCollectionViewDataSource.data[1].append(nil);
                TVClient.shared.downloadeImages(path: result.posterPath!, imageType: imageType, completion: self.handelImageResponse(image:error:imageType:))
            }
        }
    }
    
//    func handelGetPopularTVShowsResponse(response: GetPopularMovieResponse?, error: Error?) {
//            if error != nil { return }
//            if let response = response {
//    //            response.
//                HorizantalCollectionViewDataSource.imagesToLoade = response.results.count;
//                VerticalCollectionView.reloadData();
//
//                let tempArray: [UIImage?] = [];
//                HorizantalCollectionViewDataSource.data.append(tempArray);
//    //            HorizantalCollectionViewDataSource.data.append(tempArray);
//                
//                for result in response.results {
//                    let x = HorizantalCollectionViewDataSource.data.endIndex;
//                    HorizantalCollectionViewDataSource.data[HorizantalCollectionViewDataSource.data.endIndex - 1].append(nil);
//    //                HorizantalCollectionViewDataSource.data[1].append(nil);
//                    TVClient.shared.downloadeImages(path: result.posterPath!, imageType: .tv(image: nil), completion: self.handelImageResponse(image:error:imageType:))
//                }
//            }
//        }
//    func handelGetPopularTVShowsResponse(response: GetPopularResponse?, error: Error?) {
//        if error != nil { return }
//        if let response = response {
//            HorizantalCollectionViewDataSource.imagesToLoade = response.results.count;
//            VerticalCollectionView.reloadData();
//
//            let tempArray: [UIImage?] = [];
//            HorizantalCollectionViewDataSource.data.append(tempArray);
//            HorizantalCollectionViewDataSource.data.append(tempArray);
//            
//            for result in response.results {
//                HorizantalCollectionViewDataSource.data[0].append(nil);
//                HorizantalCollectionViewDataSource.data[1].append(nil);
//                TVClient.shared.downloadeImages(path: result.posterPath!, imageType: .tv(image: nil), completion: self.handelImageResponse(success:error:))
//            }
//        }
//    }
    func handelImageResponse(image: UIImage?, error: Error?, imageType: HorizantalCollectionViewDataSource.HorizantalCollectionViewType) {
        switch imageType {
        case .tv:
            _ = HorizantalCollectionViewDataSource.HorizantalCollectionViewType.tv(image: image).setData

        case .movie:
            _ = HorizantalCollectionViewDataSource.HorizantalCollectionViewType.movie(image: image).setData
        }
        VerticalCollectionView.reloadData();
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
