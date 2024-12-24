//
//  DownloadCombineViewModel.swift
//  mvvm-testing
//
//  Created by Alex Tran on 12/23/24.
//

import Foundation
import Combine

class DownloadCombineViewModel: ObservableObject {
    @Published var posts: [Post] = []
    var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
//            .tryMap { (data, response) -> Data in
//                guard let response = response as? HTTPURLResponse,
//                      response.statusCode >= 200 && response.statusCode < 300 else {
//                    throw URLError(URLError.badServerResponse)
//                }
//                
//                return data
//            }
            .tryMap(handleOutput)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    print("COMPLETION: \(completion)")
                case .failure(let err):
                    print("Error: \(err)")
                }
            } receiveValue: { [weak self] (returnedPosts) in
                self?.posts = returnedPosts
            }
            .store(in: &cancellables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(URLError.badServerResponse)
        }
        
        return output.data
    }
}
