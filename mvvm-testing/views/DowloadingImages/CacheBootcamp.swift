//
//  CacheBootcamp.swift
//  mvvm-testing
//
//  Created by Alex Tran on 12/24/24.
//

import SwiftUI

struct CacheBootcamp: View {
    @StateObject private var vm = CacheViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                }
                HStack {
                    Button(action: {
                        vm.saveToCache()
                    }, label: {
                        Text("Save to Cache")
                            .font(.headline)
                            .padding()
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(10)
                    })
                    Button(action: {
                        vm.removeFromCache()
                    }, label: {
                        Text("Delete from Cache")
                            .font(.headline)
                            .padding()
                            .foregroundColor(.white)
                            .background(.red)
                            .cornerRadius(10)
                    })
                }
                Button(action: {
                    vm.getImageFromCache()
                }, label: {
                    Text("Get from Cache")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(10)
                })
                if let image = vm.cachedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                }
                Spacer()
            }
            .navigationTitle("Cache")
            
        }
    }
}

#Preview {
    CacheBootcamp()
}
