//
//  HomeViewModel.swift
//  TokopediaMiniProject
//
//  Created by Santo Michael Sihombing on 10/04/22.
//

import Core
import RxSwift
import RxCocoa

class HomeViewModelPresentation: DisposableViewModel, HomeViewModel {
    
    
    
    private let coordinator: HomeCoordinator
   
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    let _selectedCategory = BehaviorRelay<String>(value: "Hello")
    var selectedCategory: Driver<String> {
        return _selectedCategory.asDriver()
    }
    
    func getCategory() {
        self._selectedCategory.accept(UserDefaultsManager.shared.getCategory())
    }
    
    func goToCategory(delegate: CategoryViewDelegate) {
        coordinator.toCategory(delegate: delegate)
    }
    
    func saveCategory(_ value: String) {
        self._selectedCategory.accept(value)
        UserDefaultsManager.shared.saveCategory(value: value)
    }
    
}


protocol HomeViewModelInput {
    func goToCategory(delegate: CategoryViewDelegate)
    func getCategory()
    func saveCategory(_ value: String)
}

protocol HomeViewModelOutput {
    var selectedCategory: Driver<String> { get }
}

protocol HomeViewModel: HomeViewModelInput, HomeViewModelOutput {}


