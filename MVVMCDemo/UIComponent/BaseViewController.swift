//
//  BaseViewController.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import UIKit

struct AlertInfo {
    var actions: [UIAlertAction]
    var title: String?
    var message: String?
}

class BaseViewController: UIViewController {

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func alert(alertInfo: AlertInfo) {
        DispatchQueue.main.async {
            let alertView = UIAlertController(title: alertInfo.title,
                                              message: alertInfo.message,
                                              preferredStyle: .alert)
            for action in alertInfo.actions {
                alertView.addAction(action)
            }
            self.present(alertView, animated: true, completion: nil)
        }
    }
}
