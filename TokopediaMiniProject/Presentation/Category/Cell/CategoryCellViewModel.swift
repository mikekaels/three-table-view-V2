//
//  CategoryCellViewModel.swift
//  TokopediaMiniProject
//
//  Created by Santo Michael Sihombing on 13/04/22.
//

import RxCocoa
import RxSwift
import UIKit

class CategoryCellViewModel: DisposableViewModel {
    var name: Driver<String>
    var children: Driver<String>
    
    init(name: String, children: Int, level: Int) {
        self.name = .just("\(String(repeating: "       ", count: level > 1 ? level - 1 : 0)) \(name)")
        
        self.children = .just(children != 0 ? "\(children) Children " : "")
    }
}
