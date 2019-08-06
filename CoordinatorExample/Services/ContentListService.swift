//
//  ContentServices.swift
//  CoordinatorExample
//
//  Created by malik2 on 7/20/19.
//  Copyright © 2019 malik2. All rights reserved.
//

import Foundation

protocol ContentListAPI {
    func downloadContent(completion: @escaping (Result<ContentListResponse, Error>) -> Void)
}

final class ContentListService: ContentListAPI {
    func downloadContent(completion: @escaping (Result<ContentListResponse, Error>) -> Void) {

        // ******** MOCK DATA ********
        let item1 = ContentListItem(id: "id 1", text: "text 1")
        let item2 = ContentListItem(id: "id 2", text: "text 2")
        let items = [item1, item2]
        let response = ContentListResponse(contentListItems: items)
        completion(.success(response))
        return
        // ******** MOCK DATA ********

        guard let request = ContentListRequest.create() else {
            Logger.shared.log("Could not create content list request")
            return
        }
        request.execute(completion: completion)
    }
}
