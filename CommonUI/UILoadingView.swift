//
//  UILoadingView.swift
//  CommonUI
//
//  Created by Santo Michael Sihombing on 10/04/22.
//

import UIKit
import Core

public class UILoadingView: UIView {
    
        // MARK: - Views
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = .primary
        view.startAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        view.textColor = .primary
        view.text = "Please wait"
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - View Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpLayoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
        setUpLayoutConstraint()
    }
    
    private func setUpView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .primary
        addSubview(activityIndicator)
        addSubview(descLabel)
    }
    
    private func setUpLayoutConstraint() {
        let centerYAnchor = NSLayoutConstraint
            .init(item: activityIndicator,
                  attribute: .centerY,
                  relatedBy: .equal,
                  toItem: self,
                  attribute: .centerY,
                  multiplier: 0.8,
                  constant: 0)
        
        NSLayoutConstraint.activate([
            centerYAnchor,
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            descLabel.leftAnchor.constraint(equalTo: leftAnchor),
            descLabel.rightAnchor.constraint(equalTo: rightAnchor),
            descLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 10)
        ])
    }
}
