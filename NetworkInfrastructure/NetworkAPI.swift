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
//        if !request.bodyParameters.isEmpty {
//            urlRequest.httpBody = encodeBody(bodyParamaters: request.bodyParameters,
//                                             bodyEncoding: request.bodyEncoding)
//        }
        urlRequest.timeoutInterval = 15
        return self.fetcher.fetch(request: urlRequest,
                                  decodeTo: Request.Response.self)
    }

//    private func encodeBody(bodyParamaters: [String: Any],
//                            bodyEncoding: BodyEncoding) -> Data? {
//        switch bodyEncoding {
//            case .jsonSerializationData:
//                return try? JSONSerialization.data(withJSONObject: bodyParamaters)
//            case .stringEncodingAscii:
//                return bodyParamaters.queryString.data(using: .ascii, allowLossyConversion: true)
//        }
//    }
    
    public func fetchFile<Request: APIRequest>(_ request: Request) -> Observable<Request.Response> {
        let url = Bundle.main.url(forResource: request.url, withExtension: "json")
        var urlRequest = URLRequest(url: url!)
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
