//
//  NetworkError.swift
//  NetworkInfrastructure
//
//  Created by Santo Michael Sihombing on 10/04/22.
//

import Foundation

public enum NetworkError: Error {
    case badRequest
    case forbidden
    case requestFailed
    case notFound
    case internalServerError
    case noConnected
}
