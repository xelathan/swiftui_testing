//
//  EscapingViewModel.swift
//  mvvm-testing
//
//  Created by Alex Tran on 12/22/24.
//

import Foundation

typealias Completion<T> = (_ response: T) -> ()

struct DataResponse {
    let data: String
}

class EscapingViewModel: ObservableObject {
    @Published var data: String = "Hello World!"
    
    func getData() {
        downloadData { [weak self] response in
            self?.data = response.data
        }
    }
    
    func downloadData(completer: @escaping Completion<DataResponse>) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completer(
                DataResponse(data: "DATA!!!")
            )
        }
    }
}
