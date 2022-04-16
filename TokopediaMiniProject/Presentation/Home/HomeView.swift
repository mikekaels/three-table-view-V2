//
//  HomeView.swift
//  TokopediaMiniProject
//
//  Created by Santo Michael Sihombing on 10/04/22.
//

import UIKit
import Core
import CommonUI
import Kingfisher

protocol HomeViewDelegate: AnyObject {
    
}

class HomeView: ScrollableView {
    weak var delegate: HomeViewDelegate?
    var navigationController: UINavigationController?
    
    let lblYouHaveNoSelected = UILabel()
        .configure { v in
            v.text = "You have no selected category"
            v.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    
    let imgItem = UIImageView()
        .configure { v in
            v.contentMode = .scaleToFill
            v.clipsToBounds = true
            v.kf.indicatorType = .activity
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    
    let lblSelected = UILabel()
        .configure { v in
            v.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    
    let btnSelect = UIPrimaryButton()
        .configure { v in
            v.setTitle("Select", for: .normal)
            v.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            v.setTitleColor(.buttonTitle, for: .normal)
            v.translatesAutoresizingMaskIntoConstraints = false
            
            v.widthAnchor.constraint(equalToConstant: 100).isActive = true
            v.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
    
    override func setUpUI() {
        super.setUpUI()
        
        [
            lblYouHaveNoSelected,
            imgItem,
            lblSelected,
            btnSelect
        ].forEach { addSubview($0)}
        
        NSLayoutConstraint.activate([
            lblYouHaveNoSelected.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 100),
            lblYouHaveNoSelected.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            imgItem.heightAnchor.constraint(equalToConstant: 200),
            imgItem.widthAnchor.constraint(equalToConstant: 200),
            imgItem.topAnchor.constraint(equalTo: lblYouHaveNoSelected.bottomAnchor, constant: 30),
            imgItem.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            lblSelected.topAnchor.constraint(equalTo: self.imgItem.bottomAnchor, constant: 30),
            lblSelected.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            btnSelect.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -70),
            btnSelect.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 36),
            btnSelect.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -36)
        ])
    }
}
