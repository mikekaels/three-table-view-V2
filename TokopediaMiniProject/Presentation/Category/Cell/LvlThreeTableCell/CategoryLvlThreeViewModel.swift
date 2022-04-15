//
//  CategoryLvlThreeViewModel.swift
//  TokopediaMiniProject
//
//  Created by Santo Michael Sihombing on 15/04/22.
//

import Foundation
import RxCocoa
import Core

class CategoryLvlThreeViewModel: DisposableViewModel, CategoryLblThreeViewModelOutput {
    let categories: Driver<[TreeNode]>
    
    init(categories: [TreeNode]) {
        self.categories = .just(categories)
    }
}

protocol CategoryLblThreeViewModelOutput {

}
