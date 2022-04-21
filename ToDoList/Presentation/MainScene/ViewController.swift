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

    var checkSegment = true

    var datas: [ToDo] = [
        ToDo(title: "1", content: "2", status: "ToDo", timer: Date.now),
        ToDo(title: "1", content: "2", status: "Improgress", timer: Date.now),
        ToDo(title: "1", content: "2", status: "Drio", timer: Date.now),
        ToDo(title: "1", content: "2", status: "ToDo", timer: Date.now),
        ToDo(title: "1", content: "2", status: "ToDo", timer: Date.now),
        ToDo(title: "1", content: "2", status: "ToDo", timer: Date.now),
        ToDo(title: "1", content: "2", status: "Improgress", timer: Date.now),
        ToDo(title: "1", content: "2", status: "Improgress", timer: Date.now),
        ToDo(title: "1", content: "2", status: "Drio", timer: Date.now),
    ]

    var data: [ToDo] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewToDoList.dataSource = self
        tableViewToDoList.delegate = self

        title = "To Do List"
        configureItems()
        navigationController?.navigationBar.tintColor = .systemPink

        segmentComponent.addTarget(
            self,
            action: #selector(onTapSegmentComponent(_:)), for: .valueChanged)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(onTapNextViewController))
        navigationItem.backButtonTitle = ""
        tableViewToDoList.register(UINib(nibName: "TodoCell", bundle: nil), forCellReuseIdentifier: "TodoCell")
    }

// MARK: - Func push ViewController
    @objc func onTapNextViewController() {
        let viewControllerAdd = AddTodoViewController()
        pushViewController(viewControllerAdd)
    }

// MARK: -Func next segment
    @objc func onTapSegmentComponent(_ segmentComponent: UISegmentedControl) {
        switch segmentComponent.selectedSegmentIndex {
        case 0:
            view.backgroundColor = .white
            checkSegment = true

        case 1:
            view.backgroundColor = .brown
            checkSegment = false
            data = datas.filter { $0.status == "ToDo" }

        case 2:
            view.backgroundColor = .systemPink
            checkSegment = false
            data = datas.filter { $0.status == "Improgress" }

        case 3:
            view.backgroundColor = .blue
            checkSegment = false
            data = datas.filter { $0.status == "Drio" }

        default:
            view.backgroundColor = .systemBackground
        }
        tableViewToDoList.reloadData()
    }

    private func configureItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: nil
        )
    }
}

// MARK: -UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewControllerAdd = AddTodoViewController()
        viewControllerAdd.state = .edit
        viewControllerAdd.dataTodo = datas[indexPath.row]
        pushViewController(viewControllerAdd)
        print("on tap table")
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}

// MARK: -UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if checkSegment {
            return datas.count
        }
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            switch segmentComponent.selectedSegmentIndex {
                case 0:
                    datas.remove(at: indexPath.row)

                default:
                    data.remove(at: indexPath.row)
            }

            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}
