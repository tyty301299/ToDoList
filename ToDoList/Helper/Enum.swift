//
//  enum.swift
//  ToDoList
//
//  Created by Nguyen Ty on 22/04/2022.
//

import UIKit

enum Status: Int, CaseIterable {
    case all = 0
    case toDo = 1
    case inProgress = 2
    case done = 3
}

extension Status {
    var name: String {
        switch self {
        case .all:
            return "All"
        case .toDo:
            return "ToDo"
        case .inProgress:
            return "In Progress"
        case .done:
            return "Done"
        }
    }
}

enum State {
    case add
    case edit
}
