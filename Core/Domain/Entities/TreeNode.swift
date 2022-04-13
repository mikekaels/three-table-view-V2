//
//  TreeNode.swift
//  Core
//
//  Created by Santo Michael Sihombing on 12/04/22.
//

import Foundation
import RxDataSources

public class TreeNode: NSObject {
    public var name = ""
    public var isOpen = false
    public var subNodes = [TreeNode]()
    public var levelString = ""
    public var index: String = ""
    public var parentId: String = ""
    public var highlited: String = ""
    
    public var level: Int {
        return levelString.components(separatedBy: ".").count
    }
    public var isLeaf: Bool {
        return subNodes.isEmpty
    }
    
    public override var description: String{
        return "levelString: \(levelString) name: \(name)"
    }
}

extension TreeNode: IdentifiableType {
    static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        return lhs.index == rhs.index
    }
    
    public typealias Identity = String
    
    public var identity: Identity {
        return index
    }
}

extension TreeNode{
    public var needsDisplayNodes: [TreeNode]{
        return needsDisplayNodesOf(ancestor: self)
    }
    
    public func needsDisplayNodesOf(ancestor: TreeNode) -> [TreeNode]{
        var nodes = [TreeNode]()
        for node in ancestor.subNodes {
            nodes.append(node)
            if node.isOpen {
                nodes.append(contentsOf: needsDisplayNodesOf(ancestor: node))
            }
        }
        return nodes.sorted{ $0.levelString < $1.levelString }
    }
}
