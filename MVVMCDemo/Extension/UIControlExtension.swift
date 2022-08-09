//
//  UIControlExtension.swift
//  MVVMCDemo
//
//  Created by Book on 2022/8/9.
//

import UIKit

extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping()->()) {
        addAction(UIAction { (action: UIAction) in closure() }, for: controlEvents)
    }
}
