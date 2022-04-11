//
//  CategoryRepository.swift
//  Core
//
//  Created by Santo Michael Sihombing on 11/04/22.
//

import Foundation
import RxSwift
import NetworkInfrastructure

public protocol CategoryRepository {
    func fetchCategories() -> Observable<CategoryRequests.Response>
}
