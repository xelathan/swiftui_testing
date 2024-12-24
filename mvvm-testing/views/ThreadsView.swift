//
//  ThreadsView.swift
//  mvvm-testing
//
//  Created by Alex Tran on 12/22/24.
//

import SwiftUI

struct ThreadsView: View {
    @StateObject private var viewModel = ThreadsViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                Text("Load data")
                    .onTapGesture {
                        viewModel.fetchData()
                    }
                
                ForEach(viewModel.data, id: \.self) { data in
                    Text(data)
                }
            }
        }
    }
}

#Preview {
    ThreadsView()
}
