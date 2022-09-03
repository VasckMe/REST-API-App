//
//  Address.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 30.08.22.
//

import Foundation

struct Address: Codable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: Geo?
}
