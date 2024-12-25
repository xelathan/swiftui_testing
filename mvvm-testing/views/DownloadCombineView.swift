//
//  DownloadCombineView.swift
//  mvvm-testing
//
//  Created by Alex Tran on 12/23/24.
//

import SwiftUI

struct DownloadCombineView: View {
    @StateObject private var vm = DownloadAsyncViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment:.leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

#Preview {
    DownloadCombineView()
}
