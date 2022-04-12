//
//  CategoryView.swift
//  TokopediaMiniProject
//
//  Created by Santo Michael Sihombing on 12/04/22.
//

import Foundation
import CommonUI
import UIKit

protocol CategoryViewDelegate: AnyObject {
    
}

class CategoryView: ScrollableView {
    weak var delegate: CategoryViewDelegate?
    
    var navigationController: UINavigationController?
    
    let tableview = UICustomTableView()
        .configure { v in
            v.rowHeight = 50
            v.isScrollEnabled = false
            v.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    
    override func setUpUI() {
        super.setUpUI()
        
        containerView.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            tableview.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0),
            tableview.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0),
            tableview.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: 0)
        ])
    }
}
