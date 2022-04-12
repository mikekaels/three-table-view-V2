//
//  DataModel.swift
//  TokopediaMiniProject
//
//  Created by Santo Michael Sihombing on 12/04/22.
//

import Foundation
import RxDataSources
import Core

struct DataModel {
    var header: String
    var items: [Item]
}

public typealias Item = TreeNode

extension DataModel: AnimatableSectionModelType {
    public typealias Item = TreeNode
    
    var identity: String {
        return header
    }
    
    init(original: DataModel, items: [Item]) {
        self = original
        self.items = items
    }
}
