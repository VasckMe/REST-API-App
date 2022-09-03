//
//  Photo.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 3.09.22.
//

import Foundation

struct Photo: Codable {
    let albumId: Int
    let id: Int
    let title: String?
    let url: String?
    let thumbnailUrl: String?
}
