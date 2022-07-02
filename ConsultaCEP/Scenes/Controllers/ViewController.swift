//
//  ViewController.swift
//  ConsultaCEP
//
//  Created by Renato F. dos Santos Jr on 24/05/22.
//

import UIKit

class ViewController: UIViewController {

    private var baseView: BaseViewProtocol

    init(view: BaseViewProtocol) {
        self.baseView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.configureView()
    }

    override func loadView() {
        super.loadView()
        view = baseView
    }

}

