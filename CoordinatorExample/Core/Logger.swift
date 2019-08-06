//
//  Logger.swift
//  CoordinatorExample
//
//  Created by malik2 on 7/26/19.
//  Copyright © 2019 malik2. All rights reserved.
//

import Foundation

final class Logger {
    static let shared = Logger()
    
    private init() { }
    
    func log(_ item: Any) {
        #if DEBUG
        print(item)
        #endif
    }
}

