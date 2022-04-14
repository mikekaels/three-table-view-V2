//
//  CategoryRequest.swift
//  NetworkInfrastructure
//
//  Created by Santo Michael Sihombing on 11/04/22.
//

import Foundation

public struct CategoryRequests: APIRequest {
    public typealias Response = CategoryResponse
    public var pathName: String { "tree/all"}
    public var queryParameters: [String : Any] { [:] }
    
    public init() {}
}
