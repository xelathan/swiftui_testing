//
//  CoreDataRelationshipsView.swift
//  mvvm-testing
//
//  Created by Alex Tran on 12/23/24.
//

import SwiftUI

struct CoreDataRelationshipsView: View {
    @StateObject private var vm = CoreDataRelationshipsViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Button(action: {
                        vm.updateBusiness()
                    }, label: {
                        Text("Perform Action")
                            .foregroundColor(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .cornerRadius(10)
                    })
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.businesses) { business in
                                BusinessView(business: business)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.departments) { department in
                                DepartmentView(department: department)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack(alignment: .top) {
                            ForEach(vm.employees) { employee in
                                EmployeeView(employee: employee)
                            }
                        }
                    }
                }.padding()
            }
            .navigationTitle("Relationships")
        }
    }
}

struct BusinessView: View {
    @ObservedObject var business: BusinessEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(business.name ?? "")
                .bold()
            
            if let departments = business.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments:")
                    .bold()
                ForEach(departments) { department in
                    Text(department.name ?? "")
                }
            }
            
            if let employees = business.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300)
        .background(Color.gray.opacity(0.3))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}


struct DepartmentView: View {
    @ObservedObject var department: DepartmentEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(department.name ?? "")
                .bold()
            
            if let businesses = department.businesses?.allObjects as? [BusinessEntity] {
                Text("Businesses:")
                    .bold()
                ForEach(businesses) { business in
                    Text(business.name ?? "")
                }
            }
            
            if let employees = department.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees:")
                    .bold()
                ForEach(employees) { employee in
                    Text(employee.name ?? "")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300)
        .background(Color.yellow.opacity(0.3))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct EmployeeView: View {
    @ObservedObject var employee: EmployeeEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(employee.name ?? "")
                .bold()
            Text("\(employee.age)")
            Text("\(employee.dateJoined ?? Date())")
            
            if let business = employee.business {
                Text("Business:")
                    .bold()
                Text(business.name ?? "")
            }
            
            if let department = employee.department {
                Text("Department:")
                    .bold()
                Text(department.name ?? "")
            }
        }
        .padding()
        .frame(maxWidth: 300)
        .background(Color.yellow.opacity(0.3))
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

#Preview {
    CoreDataRelationshipsView()
}
