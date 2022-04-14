//
//  FileRequest.swift
//  NetworkInfrastructure
//
//  Created by Santo Michael Sihombing on 14/04/22.
//

import Foundation
import Alamofire
import RxSwift

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

