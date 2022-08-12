//
//  RegisterViewController.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import UIKit

protocol RegisterViewControllerCoordinator: AnyObject {
    func registerViewControllerReigsterSuccess(_ viewController: RegisterViewController)
    func registerViewControllerTapLogin(_ viewController: RegisterViewController)
}

class RegisterViewController: BaseViewController {

    weak var delegate: RegisterViewControllerCoordinator?

    private let imageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "RegisterView"))
        view.contentMode = .scaleAspectFill
        return view
    }()

    private let registerButton: UIButton = {
        let button = UIButton()
        return button
    }()

    private let loginButton: UIButton = {
        let button = UIButton()
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        setupReaction()
    }
}

// MARK: - Private Function
extension RegisterViewController {
    func initView() {
        view.addSubview(imageView)
        view.addSubview(registerButton)
        view.addSubview(loginButton)

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        registerButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(64)
            make.centerY.equalTo(400)
        }

        loginButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(190)
            make.width.equalTo(48)
            make.leading.equalToSuperview().inset(72)
        }
    }

    func setupReaction() {

        registerButton.addAction { [weak self] in
            guard let self = self else { return }
            self.delegate?.registerViewControllerReigsterSuccess(self)
        }

        loginButton.addAction { [weak self] in
            guard let self = self else { return }
            self.delegate?.registerViewControllerTapLogin(self)
        }

    }
}
