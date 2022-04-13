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
//    let id: Driver<String>
    
    init(name: String,
         children: Int,
         level: Int
//         id: String
    ) {
        self.name = .just("\(String(repeating: "       ", count: level > 1 ? level - 1 : 0)) \(name)")
        
        self.children = .just(children != 0 ? "\(children) Children " : "")
//        self.id = .just(id)
    }
}
