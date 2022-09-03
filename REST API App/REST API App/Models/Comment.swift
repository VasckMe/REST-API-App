//
//  Comment.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 3.09.22.
//

import Foundation

struct Comment: Codable {
    let postId: Int
    let id: Int
    let name: String?
    let email: String?
    let body: String?
}
