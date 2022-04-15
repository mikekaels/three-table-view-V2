//
//  CategoryUseCase.swift
//  Core
//
//  Created by Santo Michael Sihombing on 16/04/22.
//

import Foundation
import RxSwift

public protocol CategoryViewUseCase {
    func getCategories() -> Observable<[TreeNode]>
    func getLocalCategories() -> Observable<[TreeNode]>
}

public class CategoryViewDomainUseCase {
    private let repository: CategoryRepository
    
    public init(repository: CategoryRepository) {
        self.repository = repository
    }
}

extension CategoryViewDomainUseCase: CategoryViewUseCase {
    public func getLocalCategories() -> Observable<[TreeNode]> {
        let data = repository.fetchLocalCategories()
        return data.map { $0.toDomain() }
    }
    
    public func getCategories() -> Observable<[TreeNode]> {
        let data = repository.fetchCategories()
        return data.map { $0.toDomain() }
    }
}
