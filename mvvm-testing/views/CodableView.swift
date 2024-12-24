//
//  CodableView.swift
//  mvvm-testing
//
//  Created by Alex Tran on 12/22/24.
//

import SwiftUI

struct CodableView: View {
    @StateObject private var viewModel = CodableViewModel()
    
    var body: some View {
        VStack {
            if let person = viewModel.person {
                Text("\(person.id)")
                Text(person.name)
                Text(person.description)
            }
        }
    }
}

#Preview {
    CodableView()
}
