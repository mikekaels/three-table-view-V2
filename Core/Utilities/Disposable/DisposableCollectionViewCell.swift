//
//  DisposableCollectionViewCell.swift
//  Core
//
//  Created by Santo Michael Sihombing on 15/04/22.
//

import UIKit
import RxSwift

class DisposableCollectionViewCell: UICollectionViewCell {
    var disposeBag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

