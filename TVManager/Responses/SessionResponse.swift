//
//  SessionResponse.swift
//  TVManager
//
//  Created by Emad Albarnawi on 05/09/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import Foundation


struct SessionResponse: Decodable {
    var sessionId: String,
    success: Bool;
}
