//
//  TodoCell.swift
//  ToDoList
//
//  Created by Nguyen Ty on 21/04/2022.
//

import UIKit

class TodoCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
//extension UITableView {
//    func register<T: UITableView >(aClass: T.Type) {
//        let className = String(describing: aClass)
//        register(UINib(nibName: className, bundle: nil),forCellReuseIdentifier: className)
//    }
//
//    func dequeueCell<T: UITableView>(aClass: T.Type, indexPath: IndexPath) -> T {
//        let className = String(describing: aClass)
//        guard let cell = dequeueReusableCell(withIdentifier: className, for: indexPath) as? T else {
//            assertionFailure("\(className) isn't exist")
//            return T()
//        }
//        return cell
//    }
//
//
//}

