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
    private let useCase: HomeViewUseCase
   
    init(useCase: HomeViewUseCase, coordinator: HomeCoordinator) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
    
    let _selectedCategory = BehaviorRelay<String>(value: "")
    let _selectedImageURL = BehaviorRelay<String>(value: "")
    
    
    var selectedCategory: Driver<String> {
        return _selectedCategory.asDriver()
    }
    
    var selectedImage: Driver<String> {
        return _selectedImageURL.asDriver()
    }
    
    func getDefault() {
        let category = useCase.getDefault()
        self._selectedImageURL.accept(category.imageURL)
        self._selectedCategory.accept(category.category)
    }
    
    func goToCategory(delegate: CategoryViewDelegate) {
        coordinator.toCategory(delegate: delegate)
    }
    
    func saveDefault(_ value: DefaultItem) {
        self._selectedImageURL.accept(value.imageURL)
        self._selectedCategory.accept(value.category)
        useCase.saveDefault(defaultItem: value)
    }
    
}


protocol HomeViewModelInput {
    func goToCategory(delegate: CategoryViewDelegate)
    func getDefault()
    func saveDefault(_ value: DefaultItem)
}

protocol HomeViewModelOutput {
    var selectedCategory: Driver<String> { get }
    var selectedImage: Driver<String> { get }
}

protocol HomeViewModel: HomeViewModelInput, HomeViewModelOutput {}


