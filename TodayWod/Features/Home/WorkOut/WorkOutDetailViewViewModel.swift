//  
//  WorkOutDetailViewViewModel.swift
//  TodayWod
//
//  Created by 오지연 on 9/17/24.
//

import Foundation
import Combine

protocol WorkOutDetailViewViewModelProtocol: ObservableObject {

}

class WorkOutDetailViewViewModel {
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        
    }
    
}

extension WorkOutDetailViewViewModel: WorkOutDetailViewViewModelProtocol {

}
