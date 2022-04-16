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
    private var input: MockHomeViewModelInput!
    private var output: MockHomeViewModelOutput!
    
    
    override func setUpWithError() throws {
        let coordinator = HomeCoordinatorImplement(navigationController: UINavigationController())
        let useCase = MockHomeDomainUseCase()
        sut = HomeViewModelPresentation(useCase: useCase, coordinator: coordinator)
        disposeBag = DisposeBag()
        output = MockHomeViewModelOutput()
        input = MockHomeViewModelInput()
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_success_save_default() {
        // given
        var category = DefaultItem()
        category.category = "car"
        category.imageURL = "car"
        
        // when
        sut.saveDefault(category)
        
        // then
        sut.selectedCategory
            .drive(onNext: { result in
                XCTAssertEqual(result, category.category)
            })
            .disposed(by: disposeBag)
        
        sut.selectedImage
            .drive(onNext: { result in
                XCTAssertEqual(result, category.imageURL)
        })
        .disposed(by: disposeBag)
    }
    
    func test_failed_save_default() {
        // given
        var category = DefaultItem()
        category.category = ""
        category.imageURL = ""
        
        // when
        sut.saveDefault(category)
        
        // then
        sut.getDefault()
        
        sut.selectedCategory
            .drive(onNext: { result in
                XCTAssertNotEqual(result, "bottle")
            })
            .disposed(by: disposeBag)
        
        sut.selectedImage
            .drive(onNext: { result in
                XCTAssertNotEqual(result, "bottle")
            })
            .disposed(by: disposeBag)
    }
    
    func test_success_get_default() {
        // given
        
        // when
        sut.getDefault()
        
        // then
        sut.selectedCategory
            .drive(onNext: { result in
                XCTAssertNotNil(result)
            })
            .disposed(by: disposeBag)
        
        // then
        sut.selectedImage
            .drive(onNext: { result in
                XCTAssertNotNil(result)
            })
            .disposed(by: disposeBag)
    
    }
    
    func test_success_get_default_but() {
        // given
        var category = DefaultItem()
        category.category = "smartphone"
        category.imageURL = "smartphone"
        
        // when
        sut.saveDefault(category)
        sut.getDefault()
        
        // then
        sut.selectedCategory
            .drive(onNext: { result in
                XCTAssertEqual(result, "")
            })
            .disposed(by: disposeBag)
        
        // then
        sut.selectedImage
            .drive(onNext: { result in
                XCTAssertEqual(result, "")
            })
            .disposed(by: disposeBag)
    
    }
}
