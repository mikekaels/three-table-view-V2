//
//  HomeView.swift
//  TokopediaMiniProject
//
//  Created by Santo Michael Sihombing on 10/04/22.
//

import UIKit
import Core
import CommonUI

protocol HomeViewDelegate: AnyObject {
    
}

class HomeView: ScrollableView {
    weak var delegate: HomeViewDelegate?
    var navigationController: UINavigationController?
    
    let tableview = UICustomTableView()
        .configure { v in
            v.rowHeight = 50
            v.isScrollEnabled = false
            v.register(CategoryViewCell.self, forCellReuseIdentifier: CategoryViewCell.identifier)
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
