//
//  APIRequest.swift
//  NetworkInfrastructure
//
//  Created by Santo Michael Sihombing on 10/04/22.
//

import Foundation
import Alamofire
import RxSwift

public struct EmptyResponse: Codable {}

public protocol APIRequest {
    associatedtype Response: Codable
    
    var baseUrl: String { get }
    var pathName: String { get }
    var method: HTTPMethod { get }
    var url: String { get }
}

extension APIRequest {
    public typealias Response = EmptyResponse
    public var baseUrl: String { APIConfiguration.baseUrl }
    public var url: String { baseUrl + pathName }
    public var method: HTTPMethod { .get }
}
