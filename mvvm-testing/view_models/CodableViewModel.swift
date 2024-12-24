//
//  CodableViewModel.swift
//  mvvm-testing
//
//  Created by Alex Tran on 12/22/24.
//

import Foundation

struct Person: Identifiable, Codable {
    let id: Int
    let name: String
    let description: String
}

class CodableViewModel: ObservableObject {
    @Published var person: Person? = nil
    
    init () {
        getData()
    }
    
    func getData() {
        guard let jsonData = getJSONData() else { return }
        print("JSON Data:")
        print(jsonData)
        
//        if let localData = try? JSONSerialization.jsonObject(with: jsonData),
//           let dictionary = localData as? [String: Any],
//           let id = dictionary["id"] as? Int,
//           let name = dictionary["name"] as? String,
//           let description = dictionary["description"] as? String {
//            person = Person(id: id, name: name, description: description)
//        }
        
        self.person = try? JSONDecoder().decode(Person.self, from: jsonData)
    }
    
    func getJSONData() -> Data? {
        let personData = Person(id: 6, name: "Alex", description: "CDM")
        let jsonPersonData = try? JSONEncoder().encode(personData)
        return jsonPersonData
    }
}
