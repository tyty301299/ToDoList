//
//  ViewController.swift
//  ToDoList
//
//  Created by Nguyen Ty on 20/04/2022.
//

import UIKit

class MainViewController: BaseViewController {
    @IBOutlet var segmentComponent: UISegmentedControl!
    @IBOutlet var tableViewToDoList: UITableView!

    var checkSegment = true

    var allDatas: [ToDo] = [
        ToDo(title: "1", content: "2", status: Status.toDo, timer: Date.now),
        ToDo(title: "1", content: "2", status: Status.toDo, timer: Date.now),
        ToDo(title: "1", content: "2", status: Status.done, timer: Date.now),
        ToDo(title: "1", content: "2", status: Status.toDo, timer: Date.now),
        ToDo(title: "1", content: "2", status: Status.toDo, timer: Date.now),
        ToDo(title: "1", content: "2", status: Status.toDo, timer: Date.now),
        ToDo(title: "1", content: "2", status: Status.inProgress, timer: Date.now),
        ToDo(title: "1", content: "2", status: Status.inProgress, timer: Date.now),
        ToDo(title: "1", content: "2", status: Status.done, timer: Date.now),
    ]

    var filterDatas: [ToDo] = []

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
        tableViewToDoList.register(aClass: TodoCell.self)
    }

    // MARK: - Func push ViewController

    @objc func onTapNextViewController() {
        pushViewController(AddTodoViewController())
    }

    // MARK: - Func on tap segment

    @objc func onTapSegmentComponent(_ segmentComponent: UISegmentedControl) {
        guard let state = Status(rawValue: segmentComponent.selectedSegmentIndex) else { return }
        switch state {
        case .all:
            checkSegment = true
        default:
            checkSegment = false
            filterDatas = allDatas.filter { $0.status == state }
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

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewControllerAdd = AddTodoViewController()
        viewControllerAdd.state = .edit
        viewControllerAdd.dataTodo = allDatas[indexPath.row]
        pushViewController(viewControllerAdd)
        print("on tap table")
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if checkSegment {
            return allDatas.count
        }
        return filterDatas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(aClass: TodoCell.self, indexPath: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            guard let state = Status(rawValue: segmentComponent.selectedSegmentIndex) else { return }
            switch state {
            case .all:
                allDatas.remove(at: indexPath.row)
            default:
                filterDatas.remove(at: indexPath.row)
            }

            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}
