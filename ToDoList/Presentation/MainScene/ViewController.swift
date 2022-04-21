//
//  ViewController.swift
//  ToDoList
//
//  Created by Nguyen Ty on 20/04/2022.
//

import UIKit

class ViewController: BaseViewController {
    @IBOutlet var tableViewToDoList: UITableView!
    @IBOutlet var segmentComponent: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewToDoList.dataSource = self
        title = "To Do List"
        configureItems()
        navigationController?.navigationBar.tintColor = .systemPink
        segmentComponent.addTarget(self, action: #selector(onTapSegmentComponent(_:)), for: .valueChanged)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(onTapNextViewController)
            )
        

        
    }

    @objc func onTapNextViewController() {
        let viewControllerAdd = AddTodoViewController()
        self.pushViewController(viewControllerAdd)
    }

    @objc func onTapSegmentComponent(_ segmentComponent: UISegmentedControl) {
        switch segmentComponent.selectedSegmentIndex {
        case 0:
            view.backgroundColor = .white
        case 1:
            view.backgroundColor = .brown
        case 2:
            view.backgroundColor = .systemPink
        case 3:
            view.backgroundColor = .blue
        default:
            view.backgroundColor = .systemBackground
        }
    }

    private func configureItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: nil
        )
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
}
