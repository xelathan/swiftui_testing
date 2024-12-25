//
//  DownloadAsyncViewModel.swift
//  mvvm-testing
//
//  Created by Alex Tran on 12/23/24.
//

import Foundation

class DownloadAsyncViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    init() {
        Task.init {
            let downloadedPosts = await getPosts()
            
            await MainActor.run {
                self.posts = downloadedPosts
            }
        }
    }
    
    func getPosts() async -> [Post] {
        do {
            guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return [] }
            let (data, urlResponse) = try await URLSession.shared.data(from: url)
            guard let urlResponse = urlResponse as? HTTPURLResponse,
                  urlResponse.statusCode >= 200 && urlResponse.statusCode < 300 else { return [] }
            let decodedPosts = try JSONDecoder().decode([Post].self, from: data)
            
            return decodedPosts
        } catch let err {
            print(err)
            return []
        }
    }
}
