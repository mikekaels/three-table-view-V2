//
//  CategoryViewCell.swift
//  TokopediaMiniProject
//
//  Created by Santo Michael Sihombing on 10/04/22.
//

import UIKit
import Core

class CategoryViewCell: UITableViewCell {
    
    var treeNode: TreeViewNode!
    
    private let categoryLabel = UILabel()
        .configure { v in
            v.numberOfLines = 0
            v.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            v.textColor = UIColor(named: ColorType.primary)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    
    private let childrenLabel = UILabel()
        .configure { v in
            v.numberOfLines = 0
            v.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            v.textColor = UIColor(named: ColorType.secondary)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    
    override func draw(_ rect: CGRect) {
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(categoryLabel)
        contentView.addSubview(childrenLabel)
        NSLayoutConstraint.activate([
            categoryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
        
            childrenLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            childrenLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(node: TreeViewNode) {
        
        if let category = node.nodeObject {
            
            if let _ = node.nodeChildren {
                self.categoryLabel.text = String(repeating: "    ", count: (category.level >= 0 ? category.level : 0)) + "\(!node.isExpanded! ? "+" : "-") \(category.title)"
            } else {
                self.categoryLabel.text = String(repeating: "    ", count: (category.level >= 0 ? category.level : 0)) + "\(!node.isExpanded! ? "+" : "-") \(category.title)"
            }
        }
        
        if let children = node.nodeChildren {
            self.childrenLabel.text = "\(children.count) Children"
        } else {
            self.childrenLabel.text = ""
        }
        
        self.treeNode = node
    }
    
   func expand() {
        if self.treeNode != nil {
            
            if self.treeNode.nodeChildren != nil {
                
                if self.treeNode.isExpanded == true {
                    
                    self.treeNode.isExpanded = false
                    
                } else {
                    
                    self.treeNode.isExpanded = true
                }
            }  else {
                
                self.treeNode.isExpanded = false
                
            }
            
            self.isSelected = false
        }
    }
}
