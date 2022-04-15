//
//  HomeViewModelTest.swift
//  TokopediaMiniProjectTests
//
//  Created by Santo Michael Sihombing on 16/04/22.
//

import XCTest
import RxSwift
import RxCocoa

@testable import TokopediaMiniProject
@testable import Core

class HomeViewModelTests: XCTestCase {
    
    private var sut: HomeViewModel!
    private var disposeBag: DisposeBag!
//    private var input: MockHomeViewModelInput!
//    private var output: MockHomeViewModelOutput!
    
    
    override func setUpWithError() throws {
        let coordinator = HomeCoordinatorImplement(navigationController: UINavigationController())
        let useCase = MockHomeDomainUseCase()
        sut = HomeViewModelPresentation(useCase: useCase, coordinator: coordinator)
        disposeBag = DisposeBag()
//        output = MockHomeViewModelOutput()
//        input = MockHomeViewModelInput()
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_success_save_category() {
        // given
        let category = "computer"
        
        // when
        sut.saveCategory(category)
        
        // then
        sut.selectedCategory
            .drive(onNext: { result in
                XCTAssertEqual(result, category)
            })
            .disposed(by: disposeBag)
    }
    
    func test_failed_save_category() {
        // given
        let category = "car"
        
        // when
        sut.saveCategory(category)
        
        // then
        sut.getCategory()
        sut.selectedCategory
            .drive(onNext: { result in
                XCTAssertNotEqual(result, "bottle")
            })
            .disposed(by: disposeBag)
    }
    
    func test_success_get_category() {
        // given
        
        // when
        sut.getCategory()
        
        // then
        sut.selectedCategory
            .drive(onNext: { result in
                XCTAssertNotNil(result)
            })
            .disposed(by: disposeBag)
    
    }
    
    func test_failed_get_category() {
        // given
        sut.saveCategory("")
        // when
        sut.getCategory()
        
        // then
        sut.selectedCategory
            .drive(onNext: { result in
                XCTAssertEqual(result, "")
            })
            .disposed(by: disposeBag)
    
    }
}
