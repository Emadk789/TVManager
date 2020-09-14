//
//  SearchViewController.swift
//  TVManager
//
//  Created by Emad Albarnawi on 13/09/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController  {
    
      

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    var data: [UIImage?] = [] {
        didSet {
            tableView.reloadData();
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad();
        
        textField.delegate = self;
        tableView.delegate = self;
        tableView.dataSource = self;
    }
}

extension SearchViewController: UITextFieldDelegate {
    //TODO: Implement this delegate methode and cancel unnessesary requests!!!
//    func textFieldDidChangeSelection(_ textField: UITextField) {
//        let url = TVClient.EndPoints.searchMovie(query: textField.text!).stringURL;
//
//        TVClient.shared.getDecodableRequest(url: url, imageType: .movie(image: nil), response: GetPopularResponse.self) { (response, type, error) in
//            if error != nil { return }
//            for image in response!.results {
//                guard let posterPath = image.posterPath else { return }
//                TVClient.shared.downloadeImages(path: posterPath, imageType: .movie(image: nil)) { (image, error, type) in
//                    self.data.append(image);
//                }
//            }
//
////            let images: [UIImage?] = [];
////            for image in response?.results {
////                images.append(image.po)
////            }
////            let image = response?.results[0].posterPath
//        }
//    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
      
        let url = TVClient.EndPoints.searchMovie(query: textField.text!).stringURL;
        print(url);

        TVClient.shared.getDecodableRequest(url: url, imageType: .movie(image: nil), response: GetPopularResponse.self) { (response, type, error) in
            if error != nil { return }
            for image in response!.results {
                guard let posterPath = image.posterPath else { return }
                TVClient.shared.downloadeImages(path: posterPath, imageType: .movie(image: nil)) { (image, error, type) in
                    self.data.append(image);
                }
            }
        
        }}
    
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.imageView!.image = data[indexPath.row];
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
}
//extension SearchViewController:
