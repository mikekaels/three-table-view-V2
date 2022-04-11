//
//  HomeUseCase.swift
//  Core
//
//  Created by Santo Michael Sihombing on 11/04/22.
//

import Foundation
import RxSwift
import NetworkInfrastructure

public protocol HomeViewUseCase {
    func getCategories() -> Observable<[CategoryItem]>
}

public class HomeViewDomainUseCase {
    private let repository: CategoryRepository
    
    public init(repository: CategoryRepository) {
        self.repository = repository
    }
}

extension HomeViewDomainUseCase: HomeViewUseCase {
    public func getCategories() -> Observable<[CategoryItem]> {
        return repository.fetchCategories().map { $0.toDomain() }
    }
    
//    public func getAllTopics(token: String) -> Observable<[Topic]> {
//        return repository.fetchAllTopics(token: token).map { $0.toDomain() }
//    }
}
