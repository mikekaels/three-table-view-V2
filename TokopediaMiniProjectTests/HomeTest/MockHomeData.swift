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

    var userDefault = DefaultItem()
    
    func getDefault() -> DefaultItem {
        userDefault.imageURL = ""
        userDefault.category = ""
        return userDefault
    }
    
    func saveDefault(defaultItem: DefaultItem) {
        self.userDefault = defaultItem
    }
}

class MockHomeViewModelInput: HomeViewModelInput {
    

    private let useCase = HomeViewDomainUseCase()
    
    func goToCategory(delegate: CategoryViewDelegate) {
        
    }
    
    func getDefault() {
        useCase.getDefault()
    }
    
    func saveDefault(_ value: DefaultItem) {
        useCase.saveDefault(defaultItem: value)
    }
    
}


class MockHomeViewModelOutput: HomeViewModelOutput {
    var selectedImage: Driver<String>
    
    var selectedCategory: Driver<String>
    
    init() {
        self.selectedCategory = BehaviorRelay<String>(value: "computer").asDriver()
        self.selectedImage = BehaviorRelay<String>(value: "computer").asDriver()
    }
}
