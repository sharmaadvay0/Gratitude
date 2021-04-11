//
//  Data.swift
//  Gratitude
//
//  Created by Advay Sharma on 4/10/21.
//

import Foundation

struct Post: Codable, Hashable {
    var body: String
    var category: String
    var date: String
    var sentimentMood: Double
    var userMood: Double
    var username: String
}

struct Feed: Decodable {
    var posts: [Post]
}

struct History: Decodable {
    var posts: [Post]
    var totalChange: Double
}

struct User: Decodable {
    var following: [String]
    var realName: String
}

struct NewPost: Codable, Hashable {
    var body: String
    var category: String
    var userMood: Double
    var username: String
}
