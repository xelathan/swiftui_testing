//
//  DownloadJSONViewModel.swift
//  mvvm-testing
//
//  Created by Alex Tran on 12/22/24.
//

import Foundation

class DownloadJSONViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        downloadData(fromURL: url) { data in
            guard let data = data,
                   let decodedData = try? JSONDecoder().decode([Post].self, from: data) else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.posts = decodedData
            }
        }
    }
    
    func downloadData(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil,
                  let data = data,
                  let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
                print("Error")
                completionHandler(nil)
                return
            }
            
            completionHandler(data)
        }.resume()
    }
}
