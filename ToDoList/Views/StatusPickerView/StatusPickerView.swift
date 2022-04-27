//
//  StatusPickerView.swift
//  ToDoList
//
//  Created by Nguyen Ty on 23/04/2022.
//

import UIKit

class StatusPickerView: UIView {

    @IBOutlet private var contentView: UIView!
    @IBOutlet weak var statusPickerView: UIPickerView!

    @IBOutlet weak var doneToolBar: UIToolbar!
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
    }
    
    private func setViews() {
        loadNibNamed(name: StatusPickerView.className)
        contentView.fixInView(self)
        statusPickerView.backgroundColor = .blue
        
        doneToolBar.backgroundColor = .darkGray
        
    }

}
extension UIView {
    func fixInView(_ container: UIView!) -> Void{
        self.frame = container.frame
        self.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(self)
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
    func loadNibNamed(name: String) {
        Bundle.main.loadNibNamed(name, owner: self, options: nil)
    }
}
