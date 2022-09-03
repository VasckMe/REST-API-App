//
//  Todo.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 3.09.22.
//

import Foundation

struct Todo: Codable {
    let userId: Int
    let id: Int
    let title: String?
    let completed: Bool?
}
