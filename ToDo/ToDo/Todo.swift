//
//  Todo.swift
//  ToDo
//
//  Created by Song Zixin on 7/26/17.
//  Copyright © 2017 Silk Song. All rights reserved.
//

import Foundation

class Todo {
    var title: String
    var date: Date
    var imageName: String
    
    init(title: String, date: Date, imageName: String) {
        
        self.title = title
        self.date = date
        self.imageName = imageName
    }
    
}
