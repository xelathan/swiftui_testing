//
//  EscapingView.swift
//  mvvm-testing
//
//  Created by Alex Tran on 12/22/24.
//

import SwiftUI

struct EscapingView: View {
    @StateObject private var vm = EscapingViewModel()
    
    var body: some View {
        Text(vm.data)
            .onTapGesture {
                vm.getData()
            }
    }
}

#Preview {
    EscapingView()
}
