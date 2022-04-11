//
//  NSObject + Extension.swift
//  TokopediaMiniProject
//
//  Created by Santo Michael Sihombing on 10/04/22.
//

import Foundation

extension NSObject {
    static var identifier: String {
        return String(describing: self)
    }
}
