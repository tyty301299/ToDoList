//
//  BaseViewController.swift
//  ToDoList
//
//  Created by Nguyen Ty on 20/04/2022.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("[HOT] \(self.className) init")
    }
    
    deinit {
        print("[HOT] \(self.className) deinit")
    }
}
