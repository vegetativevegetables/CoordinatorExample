//
//  ContentListItem.swift
//  CoordinatorExample
//
//  Created by malik2 on 7/26/19.
//  Copyright © 2019 malik2. All rights reserved.
//

import Foundation

struct ContentListItem: Decodable {
    let id: String // Most are integers, but some are alphanumeric
    let text: String
}
