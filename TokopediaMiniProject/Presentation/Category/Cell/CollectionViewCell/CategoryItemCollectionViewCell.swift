//
//  CategoryItemCollectionViewCell.swift
//  TokopediaMiniProject
//
//  Created by Santo Michael Sihombing on 15/04/22.
//

import Foundation
import UIKit
import Kingfisher
import RxSwift
import Core

class CategoryItemCollectionViewCell: UICollectionViewCell {
   
    var viewModel: CategoryItemCollectionViewModel!
    var disposeBag = DisposeBag()
    
    var imgItem = UIImageView()
        .configure { v in
            v.contentMode = .scaleAspectFill
            v.clipsToBounds = true
            let urls = URL(string: "https://ecs7.tokopedia.net/img/attachment/2019/7/8/3948/3948_852c3060-505d-4a02-9db5-cf9099b70b2d.png")
            v.kf.indicatorType = .activity
            v.kf.setImage(with: urls)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    
    var lblItem = UILabel()
        .configure { v in
            v.text = "Port USB & Audio"
            v.numberOfLines = 0
            v.textAlignment = .center
            v.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            v.textColor = UIColor(named: ColorType.primary)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    public func setupCell(imageUrl: String) {
        let urls = URL(string: imageUrl)
        imgItem.kf.setImage(with: urls)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        [imgItem, lblItem].forEach { contentView.addSubview($0)}
        
        NSLayoutConstraint.activate([
            imgItem.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            imgItem.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            imgItem.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            imgItem.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            
            lblItem.topAnchor.constraint(equalTo: imgItem.bottomAnchor, constant: 5),
            lblItem.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            lblItem.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}

extension CategoryItemCollectionViewCell: BindableType {
    func bindViewModel() {
        viewModel.imageURL.asDriver()
            .map{ [weak self] url in
                guard let `self` = self else { return }
                self.imgItem.kf.setImage(with: URL(string: url))
            }
            .drive()
            .disposed(by: disposeBag)
        
        
        viewModel.name
            .drive(lblItem.rx.text)
            .disposed(by: disposeBag)
    }
}
