//
//  HorizantalCollectionViewDataSource.swift
//  TVManager
//
//  Created by Emad Albarnawi on 08/09/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit


//let posterImages: [UIImage] = [];

struct HorizantalCollectionViewDataSource {
    static var posterImages: [UIImage?] = [];
    static var currentSection: Int = 0;
    static var imagesToLoade: Int = 0;
    
    static var data: [[UIImage?]] = [];
    
    enum HorizantalCollectionViewType {
        case tv(image: UIImage?), movie(image: UIImage?);
        
        var setData: [[UIImage?]] {
            switch self {
            case .tv(let image):
                HorizantalCollectionViewDataSource.data[0][HorizantalCollectionViewDataSource.data[0].firstIndex(of: nil) ?? 0] = image;
//                HorizantalCollectionViewDataSource.data[1][HorizantalCollectionViewDataSource.data[1].firstIndex(of: nil) ?? 0] = image;
            case .movie(let image):
                HorizantalCollectionViewDataSource.data[1][HorizantalCollectionViewDataSource.data[1].firstIndex(of: nil) ?? 0] = image;
//            default:
//                break
            }
            return [[nil]];
        }
    }
}
