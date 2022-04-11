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
    
    public init(networkAPI: NetworkAPI = NetworkAPI.instance) {
        self.networkAPI = networkAPI
    }
}

extension CategoryDataRepository: CategoryRepository {
    public func fetchCategories() -> Observable<CategoryRequests.Response> {
        let request: CategoryRequests = CategoryRequests()
        return networkAPI.fetchFile(request)
    }
    
}
