//
//  UICustomTableView.swift
//  CommonUI
//
//  Created by Santo Michael Sihombing on 10/04/22.
//

import Foundation
import UIKit
import Core

public final class UICustomTableView: UITableView {
    
    public override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height + 32)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setUpView()
    }
    
    private func setUpView() {
        backgroundColor = .background
        translatesAutoresizingMaskIntoConstraints = false
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        separatorStyle = .none
        rowHeight = UITableView.automaticDimension
    }
}
