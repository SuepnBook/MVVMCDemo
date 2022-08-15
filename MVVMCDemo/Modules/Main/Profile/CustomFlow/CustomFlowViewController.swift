//
//  ProfileAViewController.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import UIKit

protocol CustomFlowViewControllerCoordinator: AnyObject {
    func customFlowViewControllerPushNew(_ viewController: CustomFlowViewController)
    func customFlowViewControllerPresentNew(_ viewController: CustomFlowViewController)
    func customFlowViewControllerPushNewFlow(_ viewController: CustomFlowViewController)
    func customFlowViewControllerPresentNewFlow(_ viewController: CustomFlowViewController)
    func customFlowViewControllerEndThisFlow(_ viewController: CustomFlowViewController)
}

class CustomFlowViewController: BaseViewController {

    weak var coordinator: CustomFlowViewControllerCoordinator?

    private let id: String

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Coordinator : \n \(id)"
        return label
    }()

    private let pushNewButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Push New VC", for: .normal)
        return button
    }()

    private let presentNewButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Present New VC", for: .normal)
        return button
    }()

    private let pushNewFlowButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Push New Flow", for: .normal)
        return button
    }()

    private let presentNewFlowButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Present New Flow", for: .normal)
        return button
    }()

    private let endThisFlowButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("End This Flow", for: .normal)
        return button
    }()

    init(id: String) {
        self.id = id
        super.init()
    }

    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        initView()
        setupReaction()
    }
}

// MARK: - Private Function
extension CustomFlowViewController {
    private func initView() {
        view.backgroundColor = .white

        view.addSubview(stackView)

        stackView.addArrangedSubview(idLabel)
        stackView.addArrangedSubview(pushNewButton)
        stackView.addArrangedSubview(presentNewButton)
        stackView.addArrangedSubview(pushNewFlowButton)
        stackView.addArrangedSubview(presentNewFlowButton)
        stackView.addArrangedSubview(endThisFlowButton)

        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    func setupReaction() {

        pushNewButton.addAction { [weak self] in
            guard let self = self else { return }
            self.coordinator?.customFlowViewControllerPushNew(self)
        }

        presentNewButton.addAction { [weak self] in
            guard let self = self else { return }
            self.coordinator?.customFlowViewControllerPresentNew(self)
        }

        pushNewFlowButton.addAction { [weak self] in
            guard let self = self else { return }
            self.coordinator?.customFlowViewControllerPushNewFlow(self)
        }

        presentNewFlowButton.addAction { [weak self] in
            guard let self = self else { return }
            self.coordinator?.customFlowViewControllerPresentNewFlow(self)
        }

        endThisFlowButton.addAction { [weak self] in
            guard let self = self else { return }
            self.coordinator?.customFlowViewControllerEndThisFlow(self)
        }
    }
}
