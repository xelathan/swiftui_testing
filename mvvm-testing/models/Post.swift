//
//  Post.swift
//  mvvm-testing
//
//  Created by Alex Tran on 12/22/24.
//

import Foundation

class Post: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
