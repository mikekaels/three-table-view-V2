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
    func getDefault() -> DefaultItem
    func saveDefault(defaultItem: DefaultItem)
}

public class HomeViewDomainUseCase {
    public init() {}
}

extension HomeViewDomainUseCase: HomeViewUseCase {
    public func getDefault() -> DefaultItem {
        var item = DefaultItem()
        item.category = UserDefaultsManager.shared.getDefault(type: .category)
        item.imageURL = UserDefaultsManager.shared.getDefault(type: .image)
        return item
    }
    
    public func saveDefault(defaultItem: DefaultItem) {
        UserDefaultsManager.shared.saveDefault(value: defaultItem.category, type: .category)
        UserDefaultsManager.shared.saveDefault(value: defaultItem.imageURL, type: .image)
    }
    

}
