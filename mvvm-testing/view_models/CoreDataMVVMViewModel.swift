//
//  CoreDataMVVMViewModel.swift
//  mvvm-testing
//
//  Created by Alex Tran on 12/23/24.
//

import Foundation
import CoreData

class CoreDataMVVMViewModel: ObservableObject {
    let container: NSPersistentContainer
    
    @Published var savedEntities: [FruitEntity] = []
    @Published var fruitInput: String = ""
    
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, err in
            if let _ = err {
                print("ERROR")
            } else {
                print("SUCCESS")
            }
        }
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        do {
            savedEntities = try container.viewContext.fetch(request)
        }  catch let error {
            print(error)
        }
    }
    
    func addFruit() {
        let fruitToAdd = FruitEntity(context: container.viewContext)
        fruitToAdd.name = fruitInput
        fruitToAdd.id = UUID.init()
        self.fruitInput = ""
        
        saveData()
    }
    
    func deleteFruit(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        
        let entity = savedEntities[index]
        
        container.viewContext.delete(entity)
        
        saveData()
    }
    
    func udpateFruit(fruit: FruitEntity) {
        let currentName = fruit.name ?? ""
        let newName = currentName + " WOWZAH"
        fruit.name = newName
                
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print(error)
        }
    }
}
