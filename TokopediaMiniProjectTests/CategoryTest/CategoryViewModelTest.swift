//
//  CategoryViewModelTest.swift
//  TokopediaMiniProjectTests
//
//  Created by Santo Michael Sihombing on 16/04/22.
//

import XCTest
import RxSwift
import RxCocoa

@testable import TokopediaMiniProject
@testable import Core

class CategoryViewModelTests: XCTestCase {
    
//    private var sut: CategoryViewModel!
    private var disposeBag: DisposeBag!
    
    
    override func setUpWithError() throws {
//        let coordinator = CategoryCoordinatorImplement(navigationController: UINavigationController(), delegate: HomeViewController())
//        let useCase = MockCategoryDomainUseCase()
//        sut = CategoryViewModelPresentation(useCase: useCase, coordinator: coordinator)
        disposeBag = DisposeBag()
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
//        sut = nil
        try super.tearDownWithError()
    }
    
}
