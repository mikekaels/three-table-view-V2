//
//  NetworkLocal.swift
//  NetworkInfrastructure
//
//  Created by Santo Michael Sihombing on 14/04/22.
//

import Foundation
import Alamofire
import RxSwift

public class NetworkLocal {
    public static let instance = NetworkLocal()
    
    private let fetcher: FetchCapable
    
    public init(fetcher: FetchCapable = NetworkService()) {
        self.fetcher = fetcher
    }

    public func fetchFile<Request: FileRequest>(_ request: Request) -> Observable<Request.Response> {
        let path = Bundle.main.path(forResource: request.filePath, ofType: "json")
        
        let urlRequest = URL(fileURLWithPath: path!)
        
        return self.fetcher.fileFetch(request: urlRequest, decodeTo: Request.Response.self)
    }
}
