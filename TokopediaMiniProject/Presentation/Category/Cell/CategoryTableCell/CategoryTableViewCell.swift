//
//  CategoryTableViewCell.swift
//  TokopediaMiniProject
//
//  Created by Santo Michael Sihombing on 13/04/22.
//

import UIKit
import Core

class CategoryTableViewCell: DisposableTableViewCell {
    
    var treeNode: TreeNode!
    
    var viewModel: CategoryCellViewModel!
    
    private var categoryLabel = UILabel()
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
    
    
}

extension CategoryTableViewCell: BindableType {
    func bindViewModel() {
        viewModel.children
            .drive(childrenLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.highlited.asDriver()
            .map { [weak self] highlighted in
                guard let `self` = self else { return }
                
                self.viewModel.name.asDriver()
                    .map{ name in
                        return name.transform(highlighted)
                    }
                    .drive(self.categoryLabel.rx.attributedText)
                    .disposed(by: self.disposeBag)
            }
            .drive()
            .disposed(by: disposeBag)
    }
}
