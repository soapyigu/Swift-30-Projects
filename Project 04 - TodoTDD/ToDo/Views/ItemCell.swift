//
//  ItemCell.swift
//  ToDo
//
//  Created by gu, yi on 9/20/18.
//  Copyright © 2018 gu, yi. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell(with item: ToDoItem, isChecked: Bool = false) {
        if isChecked {
            let attributedString = NSAttributedString(string: item.title, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
            
            titleLabel.attributedText = attributedString
            dateLabel.text = nil
            locationLabel.text = nil
        } else {
            titleLabel.text = item.title
            
            if let timestamp = item.timestamp {
                let date = Date(timeIntervalSince1970: timestamp)
                dateLabel.text = dateFormatter.string(from: date)
            }
            
            if let location = item.location {
                locationLabel.text = location.name
            }
        }
    }

}
