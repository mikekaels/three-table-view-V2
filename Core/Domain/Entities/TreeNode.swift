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
    
    public var identity : Identity { return index }
}


extension TreeNode{
    public override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "child", let child = value as? [[String: Any]]{
            for i in 0..<child.count {
                let tree = TreeNode.modelWithDictionary(child[i], levelString: i,parent: levelString)
                subNodes.append(tree)
            }
        }
    }
    
    public static func modelWithDictionary(_ dict: [String: Any], levelString index: Int, parent levelString: String?) -> TreeNode{
        let model = TreeNode()
        model.levelString = levelString != nil ? (levelString! + ".\(index + 1)") : "\(index + 1)"
        model.name = dict["name"] as! String
        model.setValuesForKeys(dict)
        return model
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
