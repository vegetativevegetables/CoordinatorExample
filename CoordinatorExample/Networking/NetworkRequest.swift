//
//  NetworkRequest.swift
//  CoordinatorExample
//
//  Created by malik2 on 7/20/19.
//  Copyright © 2019 malik2. All rights reserved.
//

import Foundation

typealias HTTPHeaders = [String: String]

struct NetworkRequest {
    enum NetworkError: Error {
        case generic
    }

    enum NetworkMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }

    enum ContentType: String {
        case json = "application/json"
        case formUrlEncoded = "application/x-www-form-urlencoded"
    }

    let method: NetworkMethod
    let url: URL
    let headers: HTTPHeaders?
    let body: Data?

    private let urlSession: URLSession

    private static let defaultHeaders = [HTTPHeaderField.contentType: HTTPHeaderValue.json]

    init(
        url: URL,
        method: NetworkMethod,
        headers: HTTPHeaders? = defaultHeaders,
        urlSession: URLSession = .shared
    ) {
        self.url = url
        self.method = method
        self.headers = headers
        self.urlSession = urlSession
        self.body = nil
    }

    init<T: Codable>(
        url: URL,
        method: NetworkMethod,
        bodyModel: T? = nil,
        headers: HTTPHeaders? = defaultHeaders,
        urlSession: URLSession = .shared
        ) {
        self.url = url
        self.method = method
        self.headers = headers
        self.urlSession = urlSession
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        guard let bodyModel = bodyModel,
            let jsonData = try? encoder.encode(bodyModel) else {
                body = nil
                return
        }
        body = jsonData
    }

    var urlRequest: URLRequest? {
        let request: NSMutableURLRequest = NSMutableURLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalCacheData,
            timeoutInterval: 30.0
        )
        
        request.httpMethod = method.rawValue
        
        if let headers = headers {
            headers.forEach {
                request.addValue($1, forHTTPHeaderField: $0)
            }
        }
        
        request.httpBody = body
        
        return request.copy() as? URLRequest
    }
}

extension NetworkRequest {
    func execute<T: Decodable>(completion: @escaping ((Result<T, Error>) -> Void)) {
        guard let urlRequest = urlRequest else { return }
        
        let logger = Logger.shared
        logger.log("Network Request:")
        logger.log("Method Type: \(method)")
        logger.log("URL: \(url)")
        logger.log("Expected Type: \(T.self)")

        if let requestHeaders = headers { logger.log("Headers: \(requestHeaders)") }
        logger.log("Body:")
        if let json = body, let jsonString = String(data: json, encoding: .utf8) {
            logger.log(jsonString)
        }
        
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            Logger.shared.log("Network Response:")
            if let json = data, let jsonString = String(data: json, encoding: .utf8) {
                logger.log(jsonString)
            }
            if let jsonError = error { Logger.shared.log(jsonError) }
            
            if let error = error {
                completion(.failure(HTTPRequestClientError.failedRequest(description: error.localizedDescription)))
            } else {

                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .secondsSince1970
                        let decoded = try decoder.decode(T.self, from: data)
                        completion(.success(decoded))
                    } catch let decodingError {
                        if case NetworkError.generic = decodingError { return }
                        logger.log("Decoding error: \(decodingError)")

                        completion(
                            .failure(
                                HTTPRequestPayloadError.badData(
                                    description: decodingError.localizedDescription
                                )
                            )
                        )
                    }
                } else {
                    completion(
                        .failure(
                            HTTPRequestPayloadError.emptyData
                        )
                    )
                }
            }
        }
        task.resume()
    }
    
    func execute(completion: @escaping ((Result<Data, Error>) -> Void)) {
        guard let urlRequest = urlRequest else { return }
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(HTTPRequestClientError.failedRequest(description: error.localizedDescription)))
            } else {

                guard let data = data else {
                    completion(.failure(HTTPRequestPayloadError.badData(description: "Data is missing")))
                    return
                }

                completion(.success(data))
            }
        }
        task.resume()
    }
}
