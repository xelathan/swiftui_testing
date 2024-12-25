//
//  CoreDataRelationshipsViewModel.swift
//  mvvm-testing
//
//  Created by Alex Tran on 12/23/24.
//

import Foundation
import CoreData
import Combine

class CoreManager {
    static let instance = CoreManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, err in
            if let err = err {
                print("ERROR \(err)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
            print("SAVED")
        } catch let error {
            print(error)
        }
    }
}

class CoreDataRelationshipsViewModel: ObservableObject {
    
    let manager = CoreManager.instance
    private var cancellables = Set<AnyCancellable>()
    
    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity] = []
    @Published var employees: [EmployeeEntity] = []
    
    init() {
        setupPredicate()
        getBusinesses()
        getDepartments()
        getEmployees()
    }
    
    private func setupPredicate() {
        // Set up a notification observer for Core Data changes
        NotificationCenter.default
            .publisher(for: .NSManagedObjectContextDidSave, object: manager.context)
            .sink { [weak self] _ in
                self?.getBusinesses()
                self?.getDepartments()
                self?.getEmployees()
            }
            .store(in: &cancellables)
    }
    
    func getBusinesses() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")
        request.relationshipKeyPathsForPrefetching = ["departments", "employees"]
        request.sortDescriptors = [NSSortDescriptor(keyPath: \BusinessEntity.name, ascending: true)]
        
//        let filter = NSPredicate(format: "name == %@", "Apple")
//        request.predicate = filter
        do {
            self.businesses = try manager.container.viewContext.fetch(request)
        } catch let error {
            print(error)
        }
    }
    
    func getDepartments() {
        let request = NSFetchRequest<DepartmentEntity>(entityName: "DepartmentEntity")
        request.relationshipKeyPathsForPrefetching = ["businesses", "employees"]
        request.sortDescriptors = [NSSortDescriptor(keyPath: \DepartmentEntity.name, ascending: true)]
        
        do {
            self.departments = try manager.container.viewContext.fetch(request)
        } catch let error {
            print(error)
        }
    }
    
    func getEmployees() {
        let request = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        request.relationshipKeyPathsForPrefetching = ["business", "department"]
        
        do {
            self.employees = try manager.container.viewContext.fetch(request)
        } catch let error {
            print(error)
        }
    }
    
    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Facebook"
        save()
    }
    
    func addDepartment() {
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Water"
        newDepartment.businesses = [businesses[0], businesses[1], businesses[2]]
        
        newDepartment.addToEmployees(employees[1])
        save()
    }
    
    func addEmployee() {
        let newEmployee = EmployeeEntity(context: manager.context)
        newEmployee.age = 25
        newEmployee.dateJoined = Date()
        newEmployee.name = "Lily"
        
        newEmployee.business = businesses[2]
        newEmployee.department = departments.first(where: { department in
            department.name == "Engineering"
        })
        
        save()
    }
    
    func updateBusiness() {
        let existingBusiness = businesses[2]
        existingBusiness.addToDepartments(departments[0])
        
        save()
    }
    
    func save() {
        manager.save()
    }
}
