//
//  UIPrimaryButton.swift
//  CommonUI
//
//  Created by Santo Michael Sihombing on 16/04/22.
//

import UIKit
import Core

public class UIPrimaryButton: UIButton {
        // MARK: - View Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    func setUpView() {
        layer.cornerRadius = 22
        backgroundColor = .tokopediaPrimary
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 52).isActive = true
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    }
}
