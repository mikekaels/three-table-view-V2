//
//  TreeViewList.swift
//  TokopediaMiniProject
//
//  Created by Santo Michael Sihombing on 10/04/22.
//

import Foundation
import Core

class TreeViewLists {
    
    static func loadInitialData() -> [CategoryItem1] {
        let data: [CategoryItem1] = [
            CategoryItem1(id: "1", title: "1", level: 0, parentId: "-1"),
            CategoryItem1(id: "2", title: "2", level: 0, parentId: "-1"),
            CategoryItem1(id: "3", title: "3", level: 0, parentId: "-1"),
            CategoryItem1(id: "4", title: "4", level: 0, parentId: "-1"),
            
            CategoryItem1(id: "1a", title: "1a", level: 1, parentId: "1"),
            CategoryItem1(id: "1b", title: "1b", level: 1, parentId: "1"),
            CategoryItem1(id: "2a", title: "2a", level: 1, parentId: "2"),
            CategoryItem1(id: "3a", title: "3a", level: 1, parentId: "3"),
            CategoryItem1(id: "4a", title: "4a", level: 1, parentId: "4"),
            
            CategoryItem1(id: "11a", title: "11a", level: 2, parentId: "1b"),
            CategoryItem1(id: "11b", title: "11b", level: 2, parentId: "1b"),
            CategoryItem1(id: "11c", title: "11c", level: 2, parentId: "1b"),
            CategoryItem1(id: "11d", title: "11d", level: 2, parentId: "1b"),
            CategoryItem1(id: "11f", title: "11f", level: 2, parentId: "1b"),
            
            CategoryItem1(id: "111a", title: "11aa", level: 3, parentId: "11c"),
            CategoryItem1(id: "111b", title: "11ab", level: 3, parentId: "11c"),
            CategoryItem1(id: "222c", title: "222c", level: 3, parentId: "11f"),
            CategoryItem1(id: "222d", title: "222d", level: 3, parentId: "11f"),
            CategoryItem1(id: "222f", title: "222f", level: 3, parentId: "11f"),
        ]
        
        return data
    }
    
    static func loadInitialNodes(_ dataList: [CategoryItem1]) -> [TreeViewNode] {
        
        var nodes: [TreeViewNode] = []
        
        for data in dataList where data.level == 0 {
            let node: TreeViewNode = TreeViewNode()
            node.nodeLevel = data.level
            node.nodeObject = data
            node.isExpanded = false
            let newLevel = data.level + 1
            node.nodeChildren = loadChildrenNodes(dataList,
                                                  level: newLevel,
                                                  parentId: data.id)
            
            if (node.nodeChildren?.isEmpty ?? false) {
                node.nodeChildren = nil
            }
            
            nodes.append(node)
//            print("PARENT: \(data.title)-\(String(describing: node.isExpanded!))")
        }
        return nodes
    }
    
    static func loadChildrenNodes(_ dataList: [CategoryItem1],
                                  level: Int,
                                  parentId: String) -> [TreeViewNode] {
        var nodes: [TreeViewNode] = []
       
        
        for data in dataList where data.level == level && data.parentId == parentId {
            let node: TreeViewNode = TreeViewNode()
            node.nodeLevel = data.level
            node.nodeObject = data
            node.isExpanded = false
            let newLevel = level + 1
            node.nodeChildren = loadChildrenNodes(dataList,
                                                  level: newLevel,
                                                  parentId: data.id)
            
            if (node.nodeChildren?.isEmpty ?? false) {
                node.nodeChildren = nil
            }
            
            nodes.append(node)
//            print("CHILDREN: \(data.title)-\(String(describing: node.isExpanded!))")
        }
        
        return nodes
    }
}
