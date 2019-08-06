//
//  TableViewDataProvider.swift
//  CoordinatorExample
//
//  Created by malik2 on 7/20/19.
//  Copyright © 2019 malik2. All rights reserved.
//

import UIKit

protocol TableViewDataProvider: UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView? { get set }
    associatedtype ModelType
    var models: [ModelType]? { get set }
}

extension TableViewDataProvider {
    func set(listModels: [ModelType]) {
        models = listModels
        tableView?.reloadData()
    }
    
    func append(listModels: [ModelType]) {
        if var current = models {
            current.append(contentsOf: listModels)
            models = current
        } else {
            models = listModels
        }
        tableView?.reloadData()
    }
}
