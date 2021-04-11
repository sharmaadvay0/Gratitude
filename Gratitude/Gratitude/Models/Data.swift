//
//  Data.swift
//  Gratitude
//
//  Created by Advay Sharma on 4/10/21.
//

import Foundation

struct Post: Codable, Hashable {
//    "body": "Life is terrible, horrible, detestable, and miserable, but I'm grateful for burritos.",
//                "category": "food",
//                "date": "2021-04-10T21:12:08.948830+00:00",
//                "sentimentMood": 0.44999999925494194,
//                "userMood": 0.25,
//                "username": "justinyaodu"
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

struct User: Decodable {
    var following: [String]
    var realName: String
}
