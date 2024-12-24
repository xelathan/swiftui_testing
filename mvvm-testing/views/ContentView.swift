//
//  ContentView.swift
//  mvvm-testing
//
//  Created by Alex Tran on 12/20/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = ContentViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Username", text: $vm.nameInput)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(
                        Color.gray.opacity(0.2)
                    )
                    .font(.subheadline)
                    .cornerRadius(10)
                TextField("Password", text: $vm.descriptionInput)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(
                        Color.gray.opacity(0.2)
                    )
                    .font(.subheadline)
                    .cornerRadius(10)
                
                Button(action: {
                    
                }) {
                    Text("Login".uppercased())
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }.padding(.top, 30)
                
                List {
                    ForEach(vm.items, id: \.self) { item in
                        HStack {
                            Text(item.name)
                            Text(item.description)
                        }
                    }
                    .onDelete(perform: vm.deleteItem) // Enable delete functionality
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        vm.addItem(name: vm.nameInput, description: vm.descriptionInput)
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        .padding()
        }
    }
}

#Preview {
    ContentView()
}
