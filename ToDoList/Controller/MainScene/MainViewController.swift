//
//  ViewController.swift
//  ToDoList
//
//  Created by Nguyen Ty on 20/04/2022.
//

import UIKit

class MainViewController: BaseViewController {
    @IBOutlet private var statusSegment: UISegmentedControl!
    @IBOutlet private var todoListTableView: UITableView!

    var statusDataSegments: Status = .all

    private var filterDatas: [ToDo] = []
    private var allDatas: [ToDo] = [
        ToDo(id: 1, title: "1", content: "2", status: Status.toDo, timer: Date.now),
        ToDo(id: 2, title: "1", content: "2", status: Status.toDo, timer: Date.now),
        ToDo(id: 3, title: "1", content: "2", status: Status.done, timer: Date.now),
        ToDo(id: 4, title: "1", content: "2", status: Status.toDo, timer: Date.now),
        ToDo(id: 5, title: "1", content: "2", status: Status.toDo, timer: Date.now),
        ToDo(id: 6, title: "1", content: "2", status: Status.toDo, timer: Date.now),
        ToDo(id: 7, title: "1", content: "2", status: Status.inProgress, timer: Date.now),
        ToDo(id: 8, title: "1", content: "2", status: Status.inProgress, timer: Date.now),
        ToDo(id: 9, title: "1", content: "2", status: Status.done, timer: Date.now),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureItems()
    }

    override func viewWillAppear(_ animated: Bool) {
        reloadDataTable()
    }

    private func setupTableView() {
        todoListTableView.dataSource = self
        todoListTableView.delegate = self
        todoListTableView.separatorStyle = .none
        todoListTableView.register(aClass: TodoCell.self)
    }

    // MARK: - Func push ViewController

    @objc func onTapNextViewController() {
        let addTodoViewController = AddTodoViewController()
        addTodoViewController.getNewId = { () -> Int in
            self.allDatas.isEmpty ? 0 : self.allDatas[self.allDatas.endIndex - 1].id
        }
        addTodoViewController.delegate = self
        pushViewController(addTodoViewController)
    }

    // MARK: - Func on tap segment

    @IBAction func onTapSegmentComponent(_ segmentComponent: UISegmentedControl) {
        statusDataSegments = Status(rawValue: statusSegment.selectedSegmentIndex) ?? .all
        reloadDataTable()
    }

    func reloadDataTable() {
        if statusDataSegments != .all {
            filterDatas = allDatas.filter { $0.status == statusDataSegments }
        }
        todoListTableView.reloadData()
    }

    func configureItems() {
        title = "To Do"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(onTapNextViewController))
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = UIColor(red: 104 / 255,
                                                                green: 103 / 255,
                                                                blue: 246 / 255,
                                                                alpha: 1)
    }

    private func setUpImageBackGround(datas: [ToDo]) {
        if datas.isEmpty {
            todoListTableView.backgroundView = UIImageView(image: UIImage(named: "table"))
            todoListTableView.backgroundView?.contentMode = .scaleAspectFit
        } else {
            todoListTableView.backgroundView?.isHidden = true
        }
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewControllerAdd = AddTodoViewController()
        viewControllerAdd.state = .view
        switch statusDataSegments {
        case .all:
            viewControllerAdd.dataTodo = allDatas[indexPath.row]
        default:
            viewControllerAdd.dataTodo = filterDatas[indexPath.row]
        }
        viewControllerAdd.delegate = self

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
        switch statusDataSegments {
        case .all:
            setUpImageBackGround(datas: allDatas)
            return allDatas.count
        default:
            setUpImageBackGround(datas: filterDatas)
            return filterDatas.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(aClass: TodoCell.self, indexPath: indexPath)
        switch statusDataSegments {
        case .all:
            cell.insertData(dataToDo: allDatas[indexPath.row])
        default:
            cell.insertData(dataToDo: filterDatas[indexPath.row])
        }
        cell.boderConstainerStackView(cornerRadius: cell.frame.height / 20)
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var toDoDelete: ToDo?
            tableView.beginUpdates()
            switch statusDataSegments {
            case .all:
                toDoDelete = allDatas[indexPath.row]
            default:
                toDoDelete = filterDatas[indexPath.row]
                filterDatas.remove(at: indexPath.row)
            }
            if toDoDelete != nil {
                let indexDelete = allDatas.firstIndex { $0.id == toDoDelete?.id }
                allDatas.remove(at: indexDelete!)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

extension MainViewController: AddTodoViewControllerDelegate {
    func addDelegate(data: ToDo) {
        allDatas.append(data)
    }

    func editDelegate(data: ToDo) {
        guard let index = allDatas.firstIndex(where: { $0.id == data.id }) else {
            return
        }
        allDatas[index] = data
    }
}
