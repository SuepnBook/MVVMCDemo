//
//  LoginViewController.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import UIKit
import SnapKit

class LoginViewController: BaseViewController {
    
    private let imageView:UIImageView = {
        let view = UIImageView(image: UIImage(named: "LoginView"))
        view.contentMode = .scaleAspectFill
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
}

extension LoginViewController {
    func initView() {
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func binding() {
        
    }
}
