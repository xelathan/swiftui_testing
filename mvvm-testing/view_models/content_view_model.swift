//
//  content_view_model.swift
//  mvvm-testing
//
//  Created by Alex Tran on 12/20/24.
//

import Foundation
extension ContentView {
    @MainActor class ContentViewModel: ObservableObject {
        @Published var counter: Int = 0
        @Published var nameInput: String = ""
        @Published var descriptionInput: String = ""
        @Published var items: [Item] = []
        
        init() {
            
        }
        
        func increment() {
            counter += 1
        }
        
        func addItem(name: String, description: String) {
            self.items.insert(Item(name: name, description: description), at: 0)
        }
        
        func deleteItem(itemToDelete: IndexSet) {
            self.items.remove(atOffsets: itemToDelete)
        }
    }
}
