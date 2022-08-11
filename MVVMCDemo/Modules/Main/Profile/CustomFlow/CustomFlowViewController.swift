//
//  ProfileAViewController.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import UIKit

protocol CustomFlowViewControllerCoordinator: AnyObject {
    func customFlowViewControllerPushNewVC(_ vc: CustomFlowViewController)
    func customFlowViewControllerPresentNewVC(_ vc: CustomFlowViewController)
    func customFlowViewControllerPushNewFlow(_ vc: CustomFlowViewController)
    func customFlowViewControllerPresentNewFlow(_ vc: CustomFlowViewController)
    func customFlowViewControllerEndThisFlow(_ vc: CustomFlowViewController)
}

class CustomFlowViewController: BaseViewController {
    
    weak var delegate: CustomFlowViewControllerCoordinator?
    
    private let id:String
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var idLabel:UILabel = {
        let label = UILabel()
        label.text = id
        return label
    }()
    
    private let pushNewVCButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("Push New VC", for: .normal)
        return button
    }()
    
    private let presentNewVCButton: UIButton = {
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
    
    init(id:String) {
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

//MARK: - Private Function
extension CustomFlowViewController {
    private func initView() {
        view.backgroundColor = .white
        
        view.addSubview(stackView)

        stackView.addArrangedSubview(idLabel)
        stackView.addArrangedSubview(pushNewVCButton)
        stackView.addArrangedSubview(presentNewVCButton)
        stackView.addArrangedSubview(pushNewFlowButton)
        stackView.addArrangedSubview(presentNewFlowButton)
        stackView.addArrangedSubview(endThisFlowButton)
        
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func setupReaction() {
        
        pushNewVCButton.addAction { [weak self] in
            guard let self = self else { return }
            self.delegate?.customFlowViewControllerPushNewVC(self)
        }
        
        presentNewVCButton.addAction { [weak self] in
            guard let self = self else { return }
            self.delegate?.customFlowViewControllerPresentNewVC(self)
        }

        pushNewFlowButton.addAction { [weak self] in
            guard let self = self else { return }
            self.delegate?.customFlowViewControllerPushNewFlow(self)
        }
        
        presentNewFlowButton.addAction { [weak self] in
            guard let self = self else { return }
            self.delegate?.customFlowViewControllerPresentNewFlow(self)
        }
        
        endThisFlowButton.addAction { [weak self] in
            guard let self = self else { return }
            self.delegate?.customFlowViewControllerEndThisFlow(self)
        }
    }
}
