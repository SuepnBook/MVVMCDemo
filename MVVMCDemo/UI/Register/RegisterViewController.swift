//
//  RegisterViewController.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import UIKit

class RegisterViewController: BaseViewController {

    private let imageView:UIImageView = {
        let view = UIImageView(image: UIImage(named: "RegisterView"))
        view.contentMode = .scaleAspectFill
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
}

extension RegisterViewController {
    func initView() {
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func binding() {
        
    }
}
