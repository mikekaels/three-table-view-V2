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
    let name: Driver<String>
    let children: Driver<String>
    let highlited: Driver<String>
    let parentId: Driver<String>
    
    init(name: String,
         children: Int,
         level: Int,
         highlited: String,
         parentId: String
    ) {
        self.name = .just("\(String(repeating: "       ", count: level > 1 ? level - 1 : 0)) \(name)")
        self.children = .just(children != 0 ? "\(children) Children " : "")
        self.highlited = .just(highlited)
        self.parentId = .just(parentId)
    }
}
