//
//  ProfileViewController.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import UIKit

protocol ProfileViewControllerCoordinator: AnyObject {
    func profileViewControllerTapLogout(_ vc: ProfileViewController)
    func profileViewControllerStartAFlow(_ vc: ProfileViewController)
}
 
class ProfileViewController: BaseViewController {
    
    weak var delegate: ProfileViewControllerCoordinator?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .yellow
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let profileAFlowButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Start Profile A Flow", for: .normal)
        return button
    }()
    
    private lazy var viewModel:ProfileViewModel = {
        let viewModel = ProfileViewModel()
        viewModel.output = self
        return viewModel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        setupReaction()
        viewModel.viewDidLoad()
    }
}

//MARK: - Private Function
extension ProfileViewController {
    private func initView() {
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(userNameLabel)
        stackView.addArrangedSubview(ageLabel)
        stackView.addArrangedSubview(logoutButton)
        stackView.addArrangedSubview(profileAFlowButton)
        
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func setupReaction() {
        logoutButton.addAction { [weak self] in
            guard let self = self else { return }
            self.delegate?.profileViewControllerTapLogout(self)
        }
        
        profileAFlowButton.addAction { [weak self] in
            guard let self = self else { return }
            self.delegate?.profileViewControllerStartAFlow(self)
        }
    }
}

//MARK: - ProfileViewModelOutput
extension ProfileViewController: ProfileViewModelOutput {
    func profileViewModel(_ vm: ProfileViewModel, update profile: AccountDomainObject.Profile) {
        userNameLabel.text = "My name is \(profile.name)"
        ageLabel.text = "My age is \(profile.age)"
    }
}
