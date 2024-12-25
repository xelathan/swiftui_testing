//
//  FileManagerBootcamp.swift
//  mvvm-testing
//
//  Created by Alex Tran on 12/24/24.
//

import SwiftUI

struct FileManagerBootcamp: View {
    @StateObject private var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let uiImage = vm.image {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                HStack {
                    Button {
                        vm.saveImage()
                    } label: {
                        Text("Save")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(.blue)
                            .cornerRadius(10)
                        
                    }
                    Button {
                        vm.deleteImage()
                    } label: {
                        Text("Delete")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(.red)
                            .cornerRadius(10)
                        
                    }
                }
                Spacer()
            }.navigationTitle("File Manager")
        }
    }
}

#Preview {
    FileManagerBootcamp()
}
