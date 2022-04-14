//
//  NetworkAPI.swift
//  NetworkInfrastructure
//
//  Created by Santo Michael Sihombing on 10/04/22.
//

import Foundation
import Alamofire
import RxSwift

public class NetworkAPI {
    public static let instance = NetworkAPI()
    
    private let fetcher: FetchCapable
    
    public init(fetcher: FetchCapable = NetworkService()) {
        self.fetcher = fetcher
    }
    
    public func fetch<Request: APIRequest>(_ request: Request) -> Observable<Request.Response> {
        
        let components = URLComponents(string: request.url)!
        
        var urlRequest = URLRequest(url: components.url!)
        urlRequest.method = request.method
        urlRequest.timeoutInterval = 15
        return self.fetcher.fetch(request: urlRequest,
                                  decodeTo: Request.Response.self)
    }
}

extension Dictionary {
    var queryString: String {
        return self.map { "\($0.key)=\($0.value)" }
        .joined(separator: "&")
        .addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
    }
}

public enum BodyEncoding {
    case jsonSerializationData
    case stringEncodingAscii
}

extension URLRequest {
    mutating func addHeaders(_ headers: [String: String]) {
        headers.forEach { key, value in
            addValue(value, forHTTPHeaderField: key)
        }
    }
}
