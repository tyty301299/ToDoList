//
//  StatusView.swift
//  ToDoList
//
//  Created by Nguyen Ty on 23/04/2022.
//

import UIKit

class StatusView: UIView {
    
    @IBOutlet weak var viewContainer:UIView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    private func setUpView(){
        Bundle.main.loadNibNamed("StatusView", owner: self, options: nil)
        self.addSubview(viewContainer)
        viewContainer.frame = self.bounds
        viewContainer.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
}
