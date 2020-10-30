//
//  TokenResponse.swift
//  TVManager
//
//  Created by Emad Albarnawi on 04/09/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import Foundation

struct TokenResponse: Decodable {
    var expiresAt: String,
    requestToken: String,
    success: Bool;
}

struct FeedbackResponse: Decodable {
    var statusCode: Int,
        statusMessage: String
}
