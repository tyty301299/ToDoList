//
//  AddTodoViewController.swift
//  ToDoList
//
//  Created by Nguyen Ty on 20/04/2022.
//

import UIKit

class AddTodoViewController: BaseViewController {
    // MARK: - View

    @IBOutlet var lablePickerView: UITextField!
    @IBOutlet private var textViewContent: UITextView!
    @IBOutlet private var pickerDate: UIDatePicker!
//    @IBOutlet private var pickerStatus: UIPickerView!
    @IBOutlet private var textFieldTitle: UITextField!

    var viewPickerStatus = PickerViewStatus()
//    @IBOutlet private var bottomPickerViewLC: NSLayoutConstraint!

    // MARK: - data

    private var dataPickerStatus = Status.allCases
    var checkData = true
    var checkBack = true
    var state = State.add
    var dataTodo: ToDo?

    override func viewDidLoad() {
        super.viewDidLoad()

//        pickerStatus.dataSource = self
//        pickerStatus.delegate = self

        configureItems()
        addPickerViewStatus()
    }

    private func configureItems() {
        title = state == .add ? "Add ToDo" : "Edit ToDo"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Add",
            style: .done,
            target: self,
            action: #selector(addTodo(_:))
        )
        checkStateSelect()
    }

    private func addPickerViewStatus() {
        viewPickerStatus.frame = CGRect(x: 0, y: 414, width: 414, height: 414)
        view.addSubview(viewPickerStatus)

        NSLayoutConstraint.activate([
            viewPickerStatus.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            viewPickerStatus.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewPickerStatus.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewPickerStatus.topAnchor.constraint(equalTo: view.topAnchor, constant: 414),

        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

//        bottomPickerViewLC.constant = 0
//        UIView.animate(withDuration: 0.5) {
//            self.view.layoutIfNeeded()
//        }
    }

    @objc private func addTodo(_ sender: UIBarButtonItem) {
        switch state {
        case .add:
            navigationController?.popViewController(animated: true)
        case .edit:
            if checkBack {
                navigationItem.rightBarButtonItem = UIBarButtonItem(
                    title: "Save",
                    style: .done,
                    target: self,
                    action: #selector(addTodo(_:))
                )
                checkStateSelect()
            } else {
                navigationController?.popViewController(animated: true)
            }
            checkBack = !checkBack
        }
    }

    // MARK: - CHECK STATE SELECT

    func checkStateSelect() {
        textViewContent.isEditable = state == .add
        pickerDate.isEnabled = state == .add
//        pickerStatus.isUserInteractionEnabled = state == .add
        textFieldTitle.isEnabled = state == .add
    }
}

// MARK: - UIPickerViewDelegate

extension AddTodoViewController: UIPickerViewDelegate {
}

extension AddTodoViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        dataPickerStatus.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        dataPickerStatus[row].name
    }
}
