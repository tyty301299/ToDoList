//
//  ViewController+Exts.swift
//  ToDoList
//
//  Created by Nguyen Ty on 20/04/2022.
//

import UIKit

extension UIViewController {
    // MARK: - Navigator

    func pushViewController(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}

class CircleView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
        layer.cornerRadius = frame.height / 2
    }
}
