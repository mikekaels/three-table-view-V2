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
    func getCategory() -> String
    func saveCategory(value: String)
}

public class HomeViewDomainUseCase {
    public init() {}
}

extension HomeViewDomainUseCase: HomeViewUseCase {
    public func getCategory() -> String {
        return UserDefaultsManager.shared.getCategory()
    }
    
    public func saveCategory(value: String) {
        UserDefaultsManager.shared.saveCategory(value: value)
    }
    

}
