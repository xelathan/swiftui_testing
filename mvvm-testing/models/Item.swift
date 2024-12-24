//
//  Item.swift
//  mvvm-testing
//
//  Created by Alex Tran on 12/20/24.
//

import Foundation

struct Item: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let description: String
    
    init(id: UUID = UUID(), name: String, description: String) {
        self.id = id
        self.name = name
        self.description = description
    }
    
    static var sample: Item {
        Item(name: "PS5", description: "$500")
    }
}
