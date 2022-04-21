//
//  PickerViewStatus.swift
//  ToDoList
//
//  Created by Nguyen Ty on 21/04/2022.
//

import UIKit

class PickerViewStatus: UIView {
    
    @IBOutlet weak var itemDone: UIBarButtonItem!
    @IBOutlet weak var pickerViewStatus: UIPickerView!
    @IBOutlet weak var toolBarTop: UIToolbar!
    override init(frame: CGRect){
        super.init(frame: frame)
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
