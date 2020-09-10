//
//  CreateSessionWithLoginRequest.swift
//  TVManager
//
//  Created by Emad Albarnawi on 05/09/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import Foundation

struct CreateSessionWithLoginRequest: Encodable {
    var username: String,
    password: String,
    request_token: String;
}
