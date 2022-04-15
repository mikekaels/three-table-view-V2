//
//  MockHomeData.swift
//  TokopediaMiniProjectTests
//
//  Created by Santo Michael Sihombing on 16/04/22.
//

import Foundation
import Core
import RxSwift
import RxCocoa

@testable import TokopediaMiniProject

class MockHomeDomainUseCase: HomeViewUseCase {
    var userDefault = ""
    
    func getCategory() -> String {
        let data = userDefault
        return data
    }
    
    func saveCategory(value: String) {
        self.userDefault = value
    }
}

//class MockHomeViewModelInput: HomeViewModelInput {
//    private let useCase = HomeViewDomainUseCase()
//    
//    func goToCategory(delegate: CategoryViewDelegate) {
//        
//    }
//    
//    func getCategory() {
//        useCase.getCategory()
//    }
//    
//    func saveCategory(_ value: String) {
//        useCase.saveCategory(value: value)
//    }
//}


//class MockHomeViewModelOutput: HomeViewModelOutput {
//    var selectedCategory: Driver<String>
//    
//    init() {
//        self.selectedCategory = BehaviorRelay<String>(value: "computer").asDriver()
//    }
//}
