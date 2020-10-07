//
//  GetMultiSearchResponse.swift
//  TVManager
//
//  Created by Emad Albarnawi on 07/10/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import Foundation


// TODO: Just Decode the response Three times. One of them will be the correct one
struct GetMultiSearchResponse1: Decodable {
    let page: Int,
    totalResults: Int,
    totalPages: Int,
    results: [TV?];
}
struct GetMultiSearchResponse2: Decodable {
    let page: Int,
    totalResults: Int,
    totalPages: Int,
    results: [Movie?];
}
struct GetMultiSearchResponse3: Decodable {
    let page: Int,
    totalResults: Int,
    totalPages: Int,
    results: [Actor?];
}
struct TV: Decodable {
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
struct Movie: Decodable {
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
struct Actor: Decodable {
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
