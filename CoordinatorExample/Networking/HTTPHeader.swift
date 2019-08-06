//
//  HTTPHeader.swift
//  CoordinatorExample
//
//  Created by malik2 on 7/26/19.
//  Copyright © 2019 malik2. All rights reserved.
//

import Foundation

struct HTTPHeaderField {
    static let userAgent = "User-Agent"
    static let accept = "Accept"
    static let contentLength = "Content-Length"
    static let contentType = "Content-Type"
}

struct HTTPHeaderValue {
    static let json = "application/json"
    static let formEncoded = "application/x-www-form-urlencoded"
}
