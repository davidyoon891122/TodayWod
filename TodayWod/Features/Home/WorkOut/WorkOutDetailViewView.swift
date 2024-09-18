//  
//  WorkOutDetailViewView.swift
//  TodayWod
//
//  Created by 오지연 on 9/17/24.
//

import SwiftUI
 
struct WorkOutDetailViewView<Model>: View where Model: WorkOutDetailViewViewModelProtocol {
    
    @ObservedObject private var viewModel: Model
    
    init(viewModel: Model) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("Content")
    }
    
}

#Preview {
    WorkOutDetailViewView(viewModel: WorkOutDetailViewViewModel())
}
