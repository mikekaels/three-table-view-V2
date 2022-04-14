//
//  CategoryView.swift
//  TokopediaMiniProject
//
//  Created by Santo Michael Sihombing on 12/04/22.
//

import Foundation
import CommonUI
import UIKit

class CategoryView: ScrollableView {
    weak var delegate: CategoryViewDelegate?
    
    var navigationController: UINavigationController?
    
    lazy var searchController: UISearchController = UISearchController(searchResultsController: nil)
        .configure { v in
//            v.searchBar.placeholder = "Find item"
            v.searchBar.searchTextField.textColor = .primary
            v.searchBar.sizeToFit()
            
            v.definesPresentationContext = true
            v.hidesNavigationBarDuringPresentation = false
            v.obscuresBackgroundDuringPresentation = false
        }
    
    let tableview = UICustomTableView()
        .configure { v in
            v.rowHeight = 50
            v.isScrollEnabled = true
            v.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    
    override func setUpUI() {
        super.setUpUI()
        
        tableview.tableHeaderView = searchController.searchBar
        
        containerView.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            tableview.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0),
            tableview.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: 0),
            tableview.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor),
            tableview.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height - 80)
        ])
    }
}
