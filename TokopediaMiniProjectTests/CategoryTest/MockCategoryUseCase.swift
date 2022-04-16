//
//  MockCategoryUseCase.swift
//  TokopediaMiniProjectTests
//
//  Created by Santo Michael Sihombing on 16/04/22.
//


import Foundation
import Core
import RxSwift
import RxCocoa

@testable import TokopediaMiniProject

class MockPositiveCategoryDomainUseCase: CategoryViewUseCase {
    
    private var _categories = BehaviorRelay<[TreeNode]>(value: [])
    
    func getCategories() -> Observable<[TreeNode]> {
        var categories = [TreeNode]()
        
        for _ in 1...100 {
            let node = TreeNode()
            node.name = ""
            node.isOpen = false
            node.index = UUID().uuidString
            node.parentId = "0"
            
            categories.append(node)
        }
        _categories.accept(categories)
        return _categories.asObservable()
    }
    
    func getLocalCategories() -> Observable<[TreeNode]> {
        return _categories.asObservable()
    }
}

class MockNegativeCategoryDomainUseCase: CategoryViewUseCase {
    
    private var _categories = BehaviorRelay<[TreeNode]>(value: [])
    
    func getCategories() -> Observable<[TreeNode]> {
        return _categories.asObservable()
    }
    
    func getLocalCategories() -> Observable<[TreeNode]> {
        return _categories.asObservable()
    }
}

