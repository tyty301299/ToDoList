//
//  AddTodoViewController.swift
//  ToDoList
//
//  Created by Nguyen Ty on 20/04/2022.
//

import UIKit

protocol AddTodoViewControllerDelegate: AnyObject {
    func addDelegate(data: ToDo)
    func editDelegate(data: ToDo)
}

class AddTodoViewController: BaseViewController, UIGestureRecognizerDelegate {
    // MARK: - View

    @IBOutlet private var statusTextField: UITextField!
    @IBOutlet private var contentTextView: UITextView!
    @IBOutlet private var datePickerView: UIDatePicker!
    @IBOutlet private var titleTextField: UITextField!

    weak var delegate: AddTodoViewControllerDelegate?

    private let titleTabBar = Title()

    // MARK: - data

    private lazy var statusPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.selectRow((dataTodo?.status.rawValue ?? 1) - 1, inComponent: 0, animated: true)
        return pickerView
    }()
    
    private lazy var statusToolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.tintColor = UIColor.blue
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: Status.done.name, style: .plain, target: self, action: #selector(closePickerView))
        toolbar.setItems([spaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        return toolbar
    }()

    private var arrayOfStatus = Status.statusPicker.map { $0.name }

//    var checkData = true
    var state = State.add
    var dataTodo: ToDo?
    var getNewId: (() -> Int)?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        setupdataEdit()
        boderContentTextView(contentTextView: contentTextView)
        onTapViewCloseKeyBoard()

        titleTextField.delegate = self
        contentTextView.delegate = self
        statusTextField.inputView = statusPickerView
        statusTextField.inputAccessoryView = statusToolbar
    }

    private func setupdataEdit() {
        if let dataTodo = dataTodo {
            titleTextField.text = dataTodo.title
            statusTextField.text = dataTodo.status.name
            contentTextView.text = dataTodo.content
            datePickerView.date = dataTodo.timer
            datePickerView.date = dataTodo.timer
        } else {
            statusTextField.text = Status.toDo.name
        }
    }

    private func configureItems() {
        title = state == .add ? titleTabBar.addTitleToDo : titleTabBar.editTitleToDo
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: state == .add ? titleTabBar.addTitle : titleTabBar.editTitle,
            style: .done,
            target: self,
            action: #selector(addTodo(_:))
        )
        checkStateSelect()
    }

    @objc private func addTodo(_ sender: UIBarButtonItem) {
        guard titleTextField.text != "" else {
            notifyIsNotTitle()
            return
        }
        switch state {
        case .add:
            guard dataTodo == nil else { return }
            let newId = getNewId?() ?? 0
            let addData = ToDo(id: newId + 1,
                               title: String(titleTextField.text!),
                               content: String(contentTextView.text!),
                               status: Status.statusPicker.first { $0.name == statusTextField.text } ?? .toDo,
                               timer: datePickerView.date)
            delegate?.addDelegate(data: addData)
            navigationController?.popViewController(animated: true)
        case .edit:
            guard var dataTodo = dataTodo else {
                return
            }

            dataTodo.title = titleTextField.text ?? ""
            dataTodo.content = contentTextView.text ?? ""
            dataTodo.status = Status.statusPicker.first {
                $0.name == statusTextField.text
            } ?? .toDo
            dataTodo.timer = datePickerView.date
            delegate?.editDelegate(data: dataTodo)
            navigationController?.popViewController(animated: true)
        case .view:
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "Save",
                style: .done,
                target: self,
                action: #selector(addTodo(_:))
            )
            state = .edit
            checkStateSelect()
        }
    }

    // MARK: - CHECK STATE SELECT

    private func checkStateSelect() {
        contentTextView.isEditable = state != .view
        datePickerView.isEnabled = state != .view
        statusTextField.isEnabled = state != .view
        titleTextField.isEnabled = state != .view
    }
}

// MARK: - UIPickerViewDelegate

extension AddTodoViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddTodoViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        true
    }
}

extension AddTodoViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        statusTextField.text = arrayOfStatus[row]
    }
}

extension AddTodoViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        arrayOfStatus.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        arrayOfStatus[row]
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 120
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60.0
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel

        if let v = view as? UILabel {
            label = v
        } else {
            label = UILabel()
        }
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = arrayOfStatus[row]
        return label
    }
}
