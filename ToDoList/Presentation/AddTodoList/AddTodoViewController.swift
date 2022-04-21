//
//  AddTodoViewController.swift
//  ToDoList
//
//  Created by Nguyen Ty on 20/04/2022.
//

import UIKit

class AddTodoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add ToDO"
        configureItems()
     
    }

    private func configureItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Add",
            style: .done,
            target: self,
            action: #selector(addTodo(_:))
        )
    }
    
    @objc private func addTodo(_ sender: UIBarButtonItem) {
        print("123")
    }
}
