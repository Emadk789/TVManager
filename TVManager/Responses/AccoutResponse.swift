//
//  AccoutResponse.swift
//  TVManager
//
//  Created by Emad Albarnawi on 17/09/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import Foundation


struct GetDetailsResponse: Decodable {
    var id: Int,
//    iso_639_1: String,
//    iso_3166_1: String,
    name: String,
    includeAdult: Bool,
    username: String
    
//    enum codingKeys: CodingKeys {
//        let includeAdult = include_Adult
//    }
}
struct GetCreatedListsResponse: Decodable {
    let page: Int,
    totalResults: Int,
    totalPages: Int,
    results: [GetCreatedListsResult];
}
struct GetCreatedListsResult: Decodable {
//    let posterPath: String?,
//    popularity: Double?,
    let id: Int,
    itemCount: Int,
    favoriteCount: Int,
    listType: String,
    name: String,
//    title: String?,
//    originalName: String?,
    description: String
    
}
