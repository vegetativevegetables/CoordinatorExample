//
//  HTTPRequestError.swift
//  CoordinatorExample
//
//  Created by malik2 on 7/20/19.
//  Copyright © 2019 malik2. All rights reserved.
//

import Foundation

protocol HTTPRequestError: Error {
    var description: String { get }
}

enum HTTPRequestClientError: HTTPRequestError {
    case failedRequest(description: String)
    var description: String {
        switch self {
        case .failedRequest(let description): return description
        }
    }
}
enum HTTPRequestServerError: HTTPRequestError {
    case noResponse
    case notHTTP
    case badStatusCode(code: Int)
    
    var description: String {
        switch self {
        case .noResponse: return "The server returned a nil response."
        case .notHTTP: return "The server returned a response that was not convertible to an HTTPURLResponse."
        case .badStatusCode(let code): return "The server returned a bad status code: \(code)"
        }
    }
}

enum HTTPRequestPayloadError: HTTPRequestError {
    case badData(description: String)
    case emptyData
    var description: String {
        switch self {
        case .badData(let description): return "The data returned by the server was bad: \(description)"
        case .emptyData: return "The data returned by the server was empty."
        }
    }
}
