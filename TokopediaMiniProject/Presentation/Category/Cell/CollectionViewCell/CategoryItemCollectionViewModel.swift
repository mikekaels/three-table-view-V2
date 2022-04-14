//
//  CategoryItemCollectionViewModel.swift
//  TokopediaMiniProject
//
//  Created by Santo Michael Sihombing on 15/04/22.
//

import Foundation

import RxCocoa
import RxSwift
import UIKit

class CategoryItemCollectionViewModel: DisposableViewModel {
    let name: Driver<String>
    let highlited: Driver<String>
    let parentId: Driver<String>
    let imageURL: Driver<String>
    
    init(name: String,
         imageURL: String,
         level: Int,
         highlited: String,
         parentId: String
         
    ) {
        self.name = .just(name)
        self.highlited = .just(highlited)
        self.parentId = .just(parentId)
        self.imageURL = .just(imageURL)
    }
}
