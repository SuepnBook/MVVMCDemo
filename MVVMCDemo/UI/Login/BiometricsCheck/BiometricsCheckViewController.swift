//
//  BiometricsCheckViewController.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import UIKit

protocol BiometricsCheckViewControllerCoordinator: AnyObject {
    func BiometricsCheckViewControllerDidSuccess(_ vc:BiometricsCheckViewController)
}

class BiometricsCheckViewController: BaseViewController {
    
    weak var delegate:BiometricsCheckViewControllerCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
