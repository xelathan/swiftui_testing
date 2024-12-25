//
//  CoreDataMVVMView.swift
//  mvvm-testing
//
//  Created by Alex Tran on 12/23/24.
//

import SwiftUI

struct CoreDataMVVMView: View {
    @StateObject private var vm = CoreDataMVVMViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Fruit...", text: $vm.fruitInput)
                    .frame(height: 55)
                    .padding(.leading, 10)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                    .font(.headline)
                List {
                    ForEach(vm.savedEntities, id: \.id) { fruit in
                        Text(fruit.name ?? "")
                            .onTapGesture {
                                vm.udpateFruit(fruit: fruit)
                            }
                    }
                    .onDelete(perform: vm.deleteFruit)
                }.navigationTitle("Fruits")
            }
            .navigationBarItems(trailing: Button(action: {
                guard !vm.fruitInput.isEmpty else { return }
                vm.addFruit()
            }) {
                Label("Add", systemImage: "plus")
                    .foregroundColor(.blue)
            })
                .padding()
        }
    }
}

#Preview {
    CoreDataMVVMView()
}
