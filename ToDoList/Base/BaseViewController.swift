//
//  BaseViewController.swift
//  ToDoList
//
//  Created by Nguyen Ty on 20/04/2022.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        print("[HOT] \(className) init")
    }

    deinit {
        print("[HOT] \(self.className) deinit")
    }
    
    
     func onTapViewCloseKeyBoard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(closePickerView))
        view.addGestureRecognizer(tap)
    }
    
    @objc func closePickerView() {
        view.endEditing(true)
    }
    func notifyIsNotTitle() {
        let alert = UIAlertController(title: "Untitled", message: "Please enter data", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true) {
        }
    }
    func boderContentTextView(contentTextView : UITextView) {
        contentTextView.layer.borderWidth = 0.5
        contentTextView.layer.borderColor =
            UIColor.black.cgColor
        contentTextView.layer.masksToBounds = true
        contentTextView.layer.cornerRadius = 10
        contentTextView.layer.shadowColor = UIColor.black.cgColor
        contentTextView.layer.shadowOffset = CGSize(width: -3, height: -3)
        contentTextView.layer.shadowOpacity = 0.1
        contentTextView.layer.shadowRadius = 10
    }
}
  
