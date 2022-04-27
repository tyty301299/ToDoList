//
//  TodoCell.swift
//  ToDoList
//
//  Created by Nguyen Ty on 21/04/2022.
//

import UIKit

class TodoCell: UITableViewCell {
    @IBOutlet var containerView: UIView!
    @IBOutlet var containerStackView: UIStackView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var statusLable: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func insertData(dataToDo: ToDo) {
        titleLabel.text = dataToDo.title
        statusLable.text = String(dataToDo.status.name)
        timeLabel.text = setUpTimerToString(dateTime: dataToDo.timer)
        contentLabel.text = dataToDo.content
    }

    func setUpTimerToString(dateTime: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYY"
        return dateFormatter.string(from: dateTime)
    }

    func boderConstainerStackView(cornerRadius: CGFloat) {
        containerStackView.layer.borderWidth = 0.5
        containerStackView.layer.borderColor =
            UIColor.black.withAlphaComponent(0.3).cgColor
        containerStackView.layer.masksToBounds = true
        containerStackView.layer.cornerRadius = cornerRadius
        containerStackView.layer.shadowColor = UIColor.black.cgColor
        containerStackView.layer.shadowOffset = CGSize(width: -3, height: -3)
        containerStackView.layer.shadowOpacity = 0.1
        containerStackView.layer.shadowRadius = 10
    }
}
