//
//  Task.swift
//  UITableViewWithRealm
//
//  Created by Aaron on 4/11/19.
//  Copyright © 2019 Aaron. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    @objc dynamic var text: String = ""
    @objc dynamic var isCompleted: Bool = false
}

class TaskList: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    var taskList = List<Task>()
}
