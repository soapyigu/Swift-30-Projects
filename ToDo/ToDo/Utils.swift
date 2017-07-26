//
//  Utils.swift
//  ToDo
//
//  Created by Song Zixin on 7/26/17.
//  Copyright © 2017 Silk Song. All rights reserved.
//

import Foundation

func dateFromString(_ date: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: date)
}

func stringFromDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from: date)
}
