//
//  GetPopularResponse.swift
//  TVManager
//
//  Created by Emad Albarnawi on 07/09/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import Foundation


struct GetPopularResponse: Decodable {
    let page: Int,
    totalResults: Int,
    totalPages: Int,
    results: [Result];
}

struct Result: Decodable {
    let posterPath: String?,
    popularity: Double?,
    id: Int?,
    name: String?,
    title: String?,
    originalName: String?
    
}
