//
//  Data.swift
//  Gratitude
//
//  Created by Advay Sharma on 4/10/21.
//

import Foundation

struct Post: Identifiable, Decodable {
    var id: String
    var name: String
    var info: String
}
