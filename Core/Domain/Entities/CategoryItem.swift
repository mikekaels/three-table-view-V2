//
//  CategoryItem.swift
//  Core
//
//  Created by Santo Michael Sihombing on 10/04/22.
//

import Foundation
import NetworkInfrastructure

public class CategoryItem1 {
    public let id: String
    public let title: String
    public let level: Int
    public let parentId: String?
    
    public init(id: String,
                title: String,
                level: Int = 0,
                parentId: String?
    ){
        self.id = id
        self.title = title
        self.level = level
        self.parentId = parentId
    }
    
}

public class CategoryItem {
    public let id: String?
    public let name: String?
    public let iconImageUrl: String?
    public let child: [CategoryItem]?
    
    public init(id: String,
                name: String,
                iconImageUrl: String,
                child: [CategoryItem]?) {
        self.id = id
        self.name = name
        self.iconImageUrl = iconImageUrl
        self.child = child
    }
}

extension CategoryRequests.Response {
    func toDomain() -> [TreeNode]  {
        let categories = self.data.categories
        var trees = [TreeNode]()
        
        for i in 0..<categories.count{
            let tree = modelWithDictionary(categories[i], levelString: i, parent: nil, parentId: String(0))
            trees.append(tree)
        }
        
        return trees
    }
    
    func modelWithDictionary(_ dict: CategoryData, levelString index: Int, parent levelString: String?, parentId: String) -> TreeNode{
        let model = TreeNode()
        
        model.levelString = levelString != nil ? (levelString! + ".\(index + 1)") : "\(index + 1)"
        
        if let child = dict.child {
            var trees = [TreeNode]()
            for i in 0..<child.count{
                let tree = modelWithDictionary(child[i], levelString: i, parent: model.levelString, parentId: dict.id)
                trees.append(tree)
            }
            model.subNodes = trees
        }
        
        model.name = dict.name
        
        model.index = dict.id
        
        model.parentId = parentId
        
        model.tree = dict.tree
        
        model.imageURL = dict.iconImageURL
        
        return model
    }
    
    func setValue(_ dict: CategoryData) {
    }
}

extension CategoryLocalRequests.Response {
    func toDomain() -> [TreeNode]  {
        let categories = self.data.categoryAllList.categories
        var trees = [TreeNode]()
        
        for i in 0..<categories.count{
            let tree = modelWithDictionary(categories[i], levelString: i, parent: nil, parentId: String(0))
            trees.append(tree)
        }
        
        return trees
    }
    
    func modelWithDictionary(_ dict: CategoryDataLocal, levelString index: Int, parent levelString: String?, parentId: String) -> TreeNode{
        let model = TreeNode()
        model.levelString = levelString != nil ? (levelString! + ".\(index + 1)") : "\(index + 1)"
        
        if let child = dict.child {
            var trees = [TreeNode]()
            for i in 0..<child.count{
                let tree = modelWithDictionary(child[i], levelString: i, parent: model.levelString, parentId: dict.id)
                trees.append(tree)
            }
            model.subNodes = trees
        }
        
        model.name = dict.name
        
        model.index = dict.id
        
        model.parentId = parentId
        return model
    }
    
    func setValue(_ dict: CategoryData) {
    }
}

