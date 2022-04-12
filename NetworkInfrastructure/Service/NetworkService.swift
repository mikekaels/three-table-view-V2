//
//  NetworkService.swift
//  NetworkInfrastructure
//
//  Created by Santo Michael Sihombing on 10/04/22.
//

import Foundation
import Alamofire
import RxSwift

public class NetworkService: FetchCapable {
    

    private let session: Session
    
    public init(session: Session = AF) {
        self.session = session
    }
    
    public func fetch<ResponseType>(request: URLRequest,
                                    decodeTo: ResponseType.Type) -> Observable<ResponseType> where ResponseType : Decodable {
        let afRequest = session.request(request).debugLog().validate()
        
        return Observable<ResponseType>.create { observer in
            
            afRequest.responseDecodable(of: decodeTo.self) { response in
                
                switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        switch response.response?.statusCode {
                            case 400:
                                observer.onError(NetworkError.badRequest)
                            case 402:
                                observer.onError(NetworkError.requestFailed)
                            case 403:
                                observer.onError(NetworkError.forbidden)
                            case 404:
                                observer.onError(NetworkError.notFound)
                            case 500, 502, 503, 504:
                                observer.onError(NetworkError.internalServerError)
                            default:
                                observer.onError(error)
                        }
                }
            }
            
            return Disposables.create {
                afRequest.cancel()
            }
        }
    }
    
    public func fileFetch<ResponseType>(request: URL, decodeTo: ResponseType.Type) -> Observable<ResponseType> where ResponseType : Decodable {
        let afRequest = session.request(request).debugLog().validate()
        
        return Observable<ResponseType>.create { observer in
            
            afRequest.responseDecodable(of: decodeTo.self) { response in
                
                switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        switch response.response?.statusCode {
                            case 400:
                                observer.onError(NetworkError.badRequest)
                            case 402:
                                observer.onError(NetworkError.requestFailed)
                            case 403:
                                observer.onError(NetworkError.forbidden)
                            case 404:
                                observer.onError(NetworkError.notFound)
                            case 500, 502, 503, 504:
                                observer.onError(NetworkError.internalServerError)
                            default:
                                observer.onError(error)
                        }
                }
            }
            
            return Disposables.create {
                afRequest.cancel()
            }
        }
    }
}

public protocol FetchCapable {
    func fetch<ResponseType: Decodable>(request: URLRequest, decodeTo: ResponseType.Type) -> Observable<ResponseType>
    func fileFetch<ResponseType>(request: URL, decodeTo: ResponseType.Type) -> Observable<ResponseType> where ResponseType : Decodable 
}

extension Request {
    public func debugLog() -> Self {
#if DEBUG
        cURLDescription(calling: {curl in
            debugPrint("*****************************")
            debugPrint(curl)
            debugPrint("*****************************")
        })
#endif
        
        return self
    }
}
