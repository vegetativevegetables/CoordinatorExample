//
//  ContentListItemCollectionViewCellViewModel.swift
//  CoordinatorExample
//
//  Created by malik2 on 7/26/19.
//  Copyright © 2019 malik2. All rights reserved.
//

import Foundation

struct ContentListItemCollectionViewCellViewModel {
    let id: String
    let text: String

    init(contentListItem: ContentListItem) {
        id = contentListItem.id
        text = contentListItem.text
    }
}
