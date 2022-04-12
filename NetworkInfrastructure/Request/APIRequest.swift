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
    public var fileUrl: String { APIConfiguration.fileUrl }
    public var url: String { fileUrl + pathName }
    public var method: HTTPMethod { .get }
}

public protocol FileRequest {
    associatedtype Response: Codable
    
    var filePath: String { get }
    var method: HTTPMethod { get }
    var url: String { get }
}

extension FileRequest {
    public typealias Response = EmptyResponse
    public var filePath: String { APIConfiguration.fileUrl }
    public var url: String { filePath}
    public var method: HTTPMethod { .get }
}

