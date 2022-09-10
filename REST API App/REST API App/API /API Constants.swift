//
//  API Constants.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 3.09.22.
//

import Foundation

struct ApiConstants {
    // Local server
    static let serverPath = "http://localhost:3000/"
    
    // Users
    static let usersPath = serverPath + "users"
    static let usersURL = URL(string: usersPath)
    
    // Posts
    static let postsPath = serverPath + "posts"
    static let postsURL = URL(string: postsPath)
    
    // Comments
    static let commentsPath = serverPath + "comments"
    static let commentsURL = URL(string: commentsPath)
    
    // Albums
    static let albumsPath = serverPath + "albums"
    static let albumsURL = URL(string: albumsPath)
    
    // Photos
    static let photoPath = serverPath + "photos"
    static let photoURL = URL(string: photoPath)
    
    // Todos
    static let todosPath = serverPath + "todos"
    static let todosURL = URL(string: todosPath)
}
