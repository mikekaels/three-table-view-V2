//
//  ViewController.swift
//  CommonUI
//
//  Created by Santo Michael Sihombing on 10/04/22.
//

import UIKit
import RxSwift

open class ViewController: UIViewController {
    public let disposeBag = DisposeBag()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        bindViewModel()
        bindUIView()
    }
    
    open func bindViewModel() {}
    open func bindUIView() {}
}
