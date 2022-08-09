//
//  LoginViewController.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import UIKit
import SnapKit

protocol LoginViewControllerCoordinator: AnyObject {
    func loginViewControllerDidSuccessLogin(_ vc:LoginViewController)
    func loginViewControllerTapRegister(_ vc:LoginViewController)
}

class LoginViewController: BaseViewController {
    
    weak var delegate:LoginViewControllerCoordinator?
    
    private let imageView:UIImageView = {
        let view = UIImageView(image: UIImage(named: "LoginView"))
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let loginButton:UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    private lazy var viewModel:LoginViewModel = {
        let viewModel = LoginViewModel()
        viewModel.output = self
        return viewModel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
}

//MARK: - Private Function
extension LoginViewController {
    func initView() {
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func showLoginError() {
        
    }
}

//MARK: - LoginViewModelOutput
extension LoginViewController:LoginViewModelOutput {
    func loginViewModel(_ vm: LoginViewModel, with isLoginSuccess: Bool) {
        if isLoginSuccess {
            delegate?.loginViewControllerDidSuccessLogin(self)
        } else {
            showLoginError()
        }
    }
}
