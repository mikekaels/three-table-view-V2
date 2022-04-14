//
//  CategoryLocalRequest.swift
//  NetworkInfrastructure
//
//  Created by Santo Michael Sihombing on 14/04/22.
//

import Foundation
public struct CategoryLocalRequests: FileRequest {
    public typealias Response = CategoryLocalResponse
    public var filePath: String { "data" }
    
    public init() {}
    
}
