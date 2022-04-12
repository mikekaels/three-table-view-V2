//
//  CategoryItem.swift
//  Core
//
//  Created by Santo Michael Sihombing on 10/04/22.
//

import Foundation
import NetworkInfrastructure

public struct CategoryItem1: Equatable {
    public let id: String
    public let title: String
    public let level: Int
    public let parentId: String?
    
    public init(id: String,
                title: String,
                level: Int = 0,
                parentId: String?
    ){
        self.id = id
        self.title = title
        self.level = level
        self.parentId = parentId
    }
    
}

public struct CategoryItem {
    public let id: String
    public let title: String
    public let level: Int?
    public let parentId: String?
    
    public init(id: String,
                title: String,
                parentId: String? = "0",
                level: Int? = 0
    ){
        self.id = id
        self.title = title
        self.parentId = parentId
        self.level = level
    }
    
}

extension CategoryResponse {
    func toDomain() -> [CategoryItem]  {
        return []
    }
}
