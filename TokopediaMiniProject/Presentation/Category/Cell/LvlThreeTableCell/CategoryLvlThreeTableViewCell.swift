//
//  CategoryLvlThreeTableViewCell.swift
//  TokopediaMiniProject
//
//  Created by Santo Michael Sihombing on 15/04/22.
//

import Foundation
import UIKit
import Core
import RxDataSources
import RxSwift
import RxCocoa

protocol CategoryLvlThreeViewCellDelegate: AnyObject {
    func didTappedCategory(value: String)
}

class CategoryLvlThreeViewCell: DisposableTableViewCell {
    var treeNode: TreeNode!
    
    var viewModel: CategoryLvlThreeViewModel!
    
    var collectionView: UICollectionView!
    
    weak var delegate: CategoryLvlThreeViewCellDelegate?
    
    override func draw(_ rect: CGRect) {
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        setupUI()
    }
    
    private func setupUI() {
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private typealias CategoryListSectionModel = AnimatableSectionModel<String, TreeNode>
    
    private var dataSource: RxCollectionViewSectionedAnimatedDataSource<CategoryListSectionModel>!
    
    private func configureDataSource() {
        dataSource = RxCollectionViewSectionedAnimatedDataSource<CategoryListSectionModel>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .top,
                                                           reloadAnimation: .automatic,
                                                           deleteAnimation: .bottom),
            configureCell: configureCell
        )
    }
    
}

extension CategoryLvlThreeViewCell: BindableType {
    func bindViewModel() {
        guard let viewModel = self.viewModel else {
            return
        }
        
        configureDataSource()
        
        viewModel.categories.asDriver()
            .map { [CategoryListSectionModel(model: "", items: $0)]}
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(TreeNode.self).asDriver()
            .drive(onNext: { [weak self] node in
                guard let `self` = self else { return }
                self.delegate?.didTappedCategory(value: node.name)
            })
            .disposed(by: disposeBag)
    }
}

extension CategoryLvlThreeViewCell {
    private var configureCell: RxCollectionViewSectionedAnimatedDataSource<CategoryListSectionModel>.ConfigureCell {
        return { _, collectionView, indexPath, item  in
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryItemCollectionViewCell.identifier, for: indexPath) as! CategoryItemCollectionViewCell
            cell.bind(to: CategoryItemCollectionViewModel(name: item.name, imageURL: item.imageURL, level: item.level, highlited: item.highlited, parentId: item.parentId))
            return cell
        }
    }
}


extension CategoryLvlThreeViewCell {
    func setupCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        
        layout.sectionInset = UIEdgeInsets(top: 10, left: 45, bottom: 0, right: 20)
        
        layout.itemSize = CGSize(width: 150,
                                 height: 200)
        
        layout.minimumLineSpacing = 10
        
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: UIScreen.main.bounds.width,
                                                        height: 200),
                                          collectionViewLayout: layout)
        
        contentView.addSubview(collectionView!)
        
        collectionView.register(CategoryItemCollectionViewCell.self, forCellWithReuseIdentifier: CategoryItemCollectionViewCell.identifier)
        collectionView.backgroundColor = UIColor.clear
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        collectionView!.reloadData()
    }
}
