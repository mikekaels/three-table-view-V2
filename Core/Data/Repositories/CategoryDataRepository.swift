//
//  CategoryDataRepository.swift
//  Core
//
//  Created by Santo Michael Sihombing on 11/04/22.
//

import Foundation
import NetworkInfrastructure
import RxSwift

public final class CategoryDataRepository {
    private let networkAPI: NetworkAPI
    private let networkLocal: NetworkLocal
    
    public init(networkAPI: NetworkAPI = NetworkAPI.instance, networkLocal: NetworkLocal = NetworkLocal.instance) {
        self.networkAPI = networkAPI
        self.networkLocal = networkLocal
    }
}

extension CategoryDataRepository: CategoryRepository {
    public func fetchLocalCategories() -> Observable<CategoryLocalRequests.Response> {
        let request: CategoryLocalRequests = CategoryLocalRequests()
        return networkLocal.fetchFile(request)
    }
    
    public func fetchCategories() -> Observable<CategoryRequests.Response> {
        let request: CategoryRequests = CategoryRequests()
        return networkAPI.fetch(request)
    }
}
