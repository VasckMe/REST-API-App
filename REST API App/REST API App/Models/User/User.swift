//
//  User.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 30.08.22.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String?
    let username: String?
    let email: String?
    let address: Address?
    let phone: String?
    let website: String?
    let company: Company?
}
