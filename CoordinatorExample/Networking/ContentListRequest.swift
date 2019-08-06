//
//  ContentListRequest.swift
//  CoordinatorExample
//
//  Created by malik2 on 7/20/19.
//  Copyright © 2019 malik2. All rights reserved.
//

import Foundation

struct ContentListRequest {
    static func create() -> NetworkRequest? {
        return NetworkRequest.contentList()
    }
}

private extension NetworkRequest {
    static func contentList() -> NetworkRequest? {
        guard let contentListURL = Endpoint.contentList().url else { return nil }
        return NetworkRequest(url: contentListURL, method: .post)
    }
}

private extension Endpoint {
    static func contentList() -> Endpoint {
        return Endpoint(
            path: "/AxxessTech/Mobile-Projects/master/challenge.json",
            queryItems: []
        )
    }
}
