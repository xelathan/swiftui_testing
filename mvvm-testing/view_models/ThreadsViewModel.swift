//
//  ThreadsViewModel.swift
//  mvvm-testing
//
//  Created by Alex Tran on 12/22/24.
//

import Foundation

class ThreadsViewModel: ObservableObject {
    @Published var data: [String] = []
    
    func fetchData() {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            guard let self = self else { return }
            let downloadedData = self.downloadData()
            
            DispatchQueue.main.async {
                print(Thread.isMainThread)

                self.data = downloadedData
            }
        }
    }
    
    func downloadData() -> [String] {
        var data: [String] = []
        for x in 0..<100 {
            data.append("\(x)")
        }
        
        return data
    }
}
