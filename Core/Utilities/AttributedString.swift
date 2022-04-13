//
//  AttributedString.swift
//  Core
//
//  Created by Santo Michael Sihombing on 14/04/22.
//

import Foundation
import UIKit

public extension String {
    func transform(_ highlightedString: String) -> NSAttributedString {
        let attrStri = NSMutableAttributedString.init(string: self)
        let nsRange = NSString(string: self).range(of: highlightedString, options: String.CompareOptions.caseInsensitive)
        attrStri.addAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)], range: nsRange)
        return attrStri
    }
}
