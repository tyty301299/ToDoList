//
//  NSObject+Exts.swift
//  ToDoList
//
//  Created by Nguyen Ty on 20/04/2022.
//

import Foundation

extension NSObject {
    var className: String {
        String(describing: type(of: self))
    }
    
    class var className: String {
        String(describing: self)
    }
}
