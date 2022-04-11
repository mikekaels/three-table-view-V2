//
//  ScrollableView.swift
//  CommonUI
//
//  Created by Santo Michael Sihombing on 10/04/22.
//

import UIKit
import Core

open class ScrollableView: UIView {
    
    public lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .background
        view.autoresizingMask = .flexibleHeight
        view.bounces = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public let loadingView = UILoadingView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        setUpLayoutConstraint()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setUpUI() {
        backgroundColor = .background
//        addSubview(loadingView)
        addSubview(scrollView)
        scrollView.addSubview(containerView)
    }
    
    open func setUpLayoutConstraint() {
        setUpLoadingConstraint()
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            containerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            containerView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0)
        ])
    }
    
    open func setUpLoadingConstraint() {
//        NSLayoutConstraint.activate([
//            loadingView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            loadingView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
//        ])
    }

    open func showLoading(_ isFetching: Bool) {
//        loadingView.isHidden = !isFetching
//        scrollView.isHidden = isFetching
    }
    
}

