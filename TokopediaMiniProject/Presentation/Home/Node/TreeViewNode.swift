//
//  TreeViewNode.swift
//  TokopediaMiniProject
//
//  Created by Santo Michael Sihombing on 10/04/22.
//

import Foundation
import Core
import RxDataSources

class TreeViewNode {
    var nodeLevel: Int?
    var isExpanded: Bool?
    var nodeObject: CategoryItem1?
    var nodeChildren: [TreeViewNode]?
    var index: String
    
    init(index: String) {
        self.index = index
    }
}

extension TreeViewNode: IdentifiableType, Equatable {
    static func == (lhs: TreeViewNode, rhs: TreeViewNode) -> Bool {
        return lhs.index == rhs.index
    }
    
    typealias Identity = String

    var identity : Identity { return index }
}

struct SectionModel {
    var header: String
    var items: [Item]
}

typealias Item = TreeViewNode

extension SectionModel: AnimatableSectionModelType {
    public typealias Item = TreeViewNode
    
    var identity: String {
        return header
    }
    
    init(original: SectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}
