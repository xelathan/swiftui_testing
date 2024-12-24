//
//  DownloadJSON.swift
//  mvvm-testing
//
//  Created by Alex Tran on 12/22/24.
//

import SwiftUI

struct DownloadJSONView: View {
    @StateObject private var viewModel = DownloadJSONViewModel()
    
    var body: some View {
        List {
            ForEach(viewModel.posts, id: \.id) { post in
                Text(post.title)
                    .font(.headline)
                Text(post.body)
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    DownloadJSONView()
}
