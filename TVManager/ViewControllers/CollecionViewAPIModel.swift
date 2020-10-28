//
//  CollecionViewAPIModel.swift
//  TVManager
//
//  Created by Emad Albarnawi on 27/10/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit;

struct Responses {
    let response: GetPopularResponse;
//    var mediaType: TVClient.EndPoints.Kind = .movie;
    var data: [[UIImage?]] = [];
    var mediaTypes: [TVClient.EndPoints.Kind] = []
    
//    init(response: GetPopularResponse, mediaTypes: [TVClient.EndPoints.Kind]) {
//        self.response = response;
//        self.mediaTypes = mediaTypes;
//    }
}
struct Response {
    var response: GetPopularResponse;
    var mediaType: TVClient.EndPoints.Kind = .movie;
    var data: [UIImage?] = [];
}
