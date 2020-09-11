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
//    let verticalCollectionViewCell = VerticalCollectionViewCell();
//    var custom: customHorizantalCollectionViewDelegate?;
    override func viewDidLoad() {
        super.viewDidLoad();
        // TODO: Add an escaping closure to know when the finishes and then start downloading the images and reloade the vViewController
        TVClient.shared.getPopularTVShows(completion: self.handelGetPopularTVShowsResponse(response:error:));

        VerticalCollectionView.delegate = verticalCollectionViewController;
        VerticalCollectionView.dataSource = verticalCollectionViewController;
//        custom?.reloadeCollectionView();
//        print(custom);
//        vViewController.
//        verticalCollectionViewCell.
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
//        custom?.reloadeCollectionView();
//        print(custom);
    }
    func handelGetPopularTVShowsResponse(response: GetPopularResponse?, error: Error?) {
        if error != nil { return }
        if let response = response {
            HorizantalCollectionViewDataSource.imagesToLoade = response.results.count;
            VerticalCollectionView.reloadData();
//            for i in 0..<response.results.count {
//                HorizantalCollectionViewDataSource.posterImages[i] = nil;
//            }
            let tempArray: [UIImage?] = [];
            HorizantalCollectionViewDataSource.data.append(tempArray);
            HorizantalCollectionViewDataSource.data.append(tempArray);
            
            for result in response.results {
//                HorizantalCollectionViewDataSource.posterImages[
//                HorizantalCollectionViewDataSource.posterImages.append(nil);
                HorizantalCollectionViewDataSource.data[0].append(nil);
                HorizantalCollectionViewDataSource.data[1].append(nil);
                TVClient.shared.downloadeImages(path: result.posterPath!, imageType: .tv(image: nil), completion: self.handelImageResponse(success:error:))
            }
        }
        
//        if success {
//            //TODO: Add the request to downloade the images;
//            VerticalCollectionView.reloadData();
//        }
    }
    func handelImageResponse(success: Bool, error: Error?) {
        VerticalCollectionView.reloadData();
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
