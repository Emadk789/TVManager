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
    var data: [[UIImage?]] = [];
}
struct Response {
    var response: GetPopularResponse;
    var data: [UIImage?] = [];
}
