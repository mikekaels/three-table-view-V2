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
    
    private var sut: CategoryViewModel!
    private var disposeBag: DisposeBag!
    
    
    override func setUpWithError() throws {
        let coordinator = CategoryCoordinatorImplement(navigationController: UINavigationController(), delegate: HomeViewController())
        let useCase = MockPositiveCategoryDomainUseCase()
        sut = CategoryViewModelPresentation(useCase: useCase, coordinator: coordinator)
        disposeBag = DisposeBag()
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_success_get_categories() {
        // given
        let loadDataExpectation = expectation(description: "Should return categories with value")
        
        let coordinator = CategoryCoordinatorImplement(navigationController: UINavigationController(), delegate: HomeViewController())
        let useCase = MockPositiveCategoryDomainUseCase()
        sut = CategoryViewModelPresentation(useCase: useCase, coordinator: coordinator)
        
        // when
        sut.categories
            .drive(onNext: { result in
                XCTAssertNotNil(result)
                loadDataExpectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        // then
        wait(for: [loadDataExpectation], timeout: 1)
    }
    
    func test_success_get_categories_but_zero() {
        // given
        let loadDataExpectation = expectation(description: "Should Get 0 categories")
        
        let coordinator = CategoryCoordinatorImplement(navigationController: UINavigationController(), delegate: HomeViewController())
        let useCase = MockNegativeCategoryDomainUseCase()
        sut = CategoryViewModelPresentation(useCase: useCase, coordinator: coordinator)
        
        // when
        sut.categories
            .drive(onNext: { result in
                XCTAssertEqual(result, [])
                loadDataExpectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        // then
        wait(for: [loadDataExpectation], timeout: 1)
    }
    
}
