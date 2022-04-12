//
//  CategoryRequest.swift
//  NetworkInfrastructure
//
//  Created by Santo Michael Sihombing on 11/04/22.
//

import Foundation

public struct CategoryRequests: FileRequest {
    public typealias Response = CategoryResponse
    public var filePath: String { "data" }
    
    public init() {}
}
