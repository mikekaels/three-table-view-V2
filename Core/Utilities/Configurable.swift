//
//  Configurable.swift
//  Core
//
//  Created by Santo Michael Sihombing on 10/04/22.
//

import Foundation
import UIKit

public protocol Configurable {}

public extension Configurable {
    @discardableResult
    func configure(completion: (Self) -> Void) -> Self {
        completion(self)
        return self
    }
}

extension NSObject: Configurable {}
