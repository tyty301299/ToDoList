//
//  AddTodoViewController.swift
//  ToDoList
//
//  Created by Nguyen Ty on 20/04/2022.
//

import UIKit

protocol AddTodoViewControllerDelegate {
    func addDelegate(data: ToDo)
    func editDelegate(data: ToDo)
}

class AddTodoViewController: BaseViewController, UIGestureRecognizerDelegate {
    // MARK: - View

    @IBOutlet var statusTextField: UITextField!
    @IBOutlet var lablePickerView: UITextField!
    @IBOutlet private var textViewContent: UITextView!
    @IBOutlet private var pickerDate: UIDatePicker!
    @IBOutlet private var textFieldTitle: UITextField!

    var delegate: AddTodoViewControllerDelegate?

    // MARK: - data

    let statusPickerView = UIPickerView()
    var arrayOfStatus = ["ToDo", "In Progress", "Done"]

    private var dataPickerStatus = Status.allCases
    var checkData = true
    var checkBack = true
    var state = State.add
    var dataTodo: ToDo?
    var getNewId: (() -> Int)?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureItems()
        createPickerView()
        createToolbar()
        setupdataEdit()
        boderContentTextView()
        onTapViewCloseKeyBoard()

        textFieldTitle.delegate = self
        textViewContent.delegate = self
    }

    func onTapViewCloseKeyBoard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(closePickerView))
        view.addGestureRecognizer(tap)
    }

    func setupdataEdit() {
        if dataTodo != nil {
            textFieldTitle.text = dataTodo?.title
            pickerDate.date = dataTodo?.timer ?? Date.now
            textViewContent.text = dataTodo?.content
            switch dataTodo?.status.rawValue {
            case 0:
                lablePickerView.text = "ToDo"
            default:
                lablePickerView.text = dataTodo?.status.name
            }
            pickerDate.date = dataTodo?.timer ?? Date.now
        }
    }

    @objc func createPickerView() {
        statusPickerView.delegate = self
        statusPickerView.delegate?.pickerView?(statusPickerView, didSelectRow: 0, inComponent: 0)
        statusTextField.inputView = statusPickerView
    }

    func createToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.tintColor = UIColor.blue
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(closePickerView))
        toolbar.setItems([spaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        statusTextField.inputAccessoryView = toolbar
    }

    @objc func closePickerView() {
        view.endEditing(true)
    }

    private func configureItems() {
        title = state == .add ? "Add ToDo" : "Edit ToDo"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: state == .add ? "Add" : "Edit",
            style: .done,
            target: self,
            action: #selector(addTodo(_:))
        )
        checkStateSelect()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @objc private func addTodo(_ sender: UIBarButtonItem) {
        switch state {
        case .add:
            if dataTodo == nil {
                if textFieldTitle.text == "" {
                    notifyIsNotTitle()
                } else {
                    let restData = ToDo(id: -1, title: "", content: "", status: .all, timer: Date.now)
                    let addData = setUpDataTodo(data: restData)
                    delegate?.addDelegate(data: addData)
                    navigationController?.popViewController(animated: true)
                }

            } else {
                if textFieldTitle.text! == "" {
                    notifyIsNotTitle()
                } else {
                    let editData = setUpDataTodo(data: dataTodo!)
                    delegate?.editDelegate(data: editData)
                    navigationController?.popViewController(animated: true)
                }
            }

        case .edit:
            if checkBack {
                navigationItem.rightBarButtonItem = UIBarButtonItem(
                    title: "Save",
                    style: .done,
                    target: self,
                    action: #selector(addTodo(_:))
                )
                state = .add
                checkStateSelect()
            } else {
                navigationController?.popViewController(animated: true)
            }
            checkBack = !checkBack
        }
    }

    func setUpDataTodo(data: ToDo) -> ToDo {
        if data.id == -1 {
            var statusNew = Status.toDo
            switch lablePickerView.text! {
            case "ToDo":
                statusNew = .toDo
            case "In Progress":
                statusNew = .inProgress
            case "Done":
                statusNew = .done
            default:
                statusNew = .all
            }
            let newId = getNewId?() ?? 0
            let addData = ToDo(id: newId + 1,
                               title: String(textFieldTitle.text!),
                               content: String(textViewContent.text!),
                               status: statusNew,
                               timer: pickerDate.date)
            return addData
        } else {
            var editData = data
            editData.title = textFieldTitle.text ?? ""
            editData.content = textViewContent.text ?? ""
            editData.timer = pickerDate.date
            print(pickerDate.date)

            switch lablePickerView.text! {
            case "ToDo":
                editData.status = Status.toDo
            case "In Progress":
                editData.status = Status.inProgress
            case "Done":
                editData.status = Status.done
            default:
                editData.status = Status.all
            }
            return editData
        }
    }

    func notifyIsNotTitle() {
        let alert = UIAlertController(title: "Untitled", message: "Please enter data", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true) {
        }
    }

    func boderContentTextView() {
        textViewContent.layer.borderWidth = 0.5
        textViewContent.layer.borderColor =
            UIColor.black.cgColor
        textViewContent.layer.masksToBounds = true
        textViewContent.layer.cornerRadius = 10
        textViewContent.layer.shadowColor = UIColor.black.cgColor
        textViewContent.layer.shadowOffset = CGSize(width: -3, height: -3)
        textViewContent.layer.shadowOpacity = 0.1
        textViewContent.layer.shadowRadius = 10
    }

    // MARK: - CHECK STATE SELECT

    func checkStateSelect() {
        textViewContent.isEditable = state == .add
        pickerDate.isEnabled = state == .add
        lablePickerView.isEnabled = state == .add
        textFieldTitle.isEnabled = state == .add
    }
}

// MARK: - UIPickerViewDelegate

extension AddTodoViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddTodoViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
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
