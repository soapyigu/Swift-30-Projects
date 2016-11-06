//
//  Helper.swift
//  Whatsapp
//
//  Copyright © 2016 Yi Gu. All rights reserved.
//

import Foundation
import UIKit

public class Helper {
  public static func setupContraints(view: UIView, superView: UIView, constraints: [NSLayoutConstraint]) {
    view.translatesAutoresizingMaskIntoConstraints = false
    
    superView.addSubview(view)
    
    NSLayoutConstraint.activate(constraints)
  }
  
  public static func dateToStr(date: Date?) -> String {
    guard let date = date else {
      return ""
    }
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "MMM dd, YYYY"
    return dateFormat.string(from: date)
  }
  
  public static func insertImageToWords(startWords: String, endWords: String, imageName: String) -> NSMutableAttributedString {
    // create an NSMutableAttributedString that we'll append everything to
    let fullString = NSMutableAttributedString(string: startWords)
    
    // create our NSTextAttachment
    let image1Attachment = NSTextAttachment()
    image1Attachment.image = UIImage(named: imageName)
    
    // wrap the attachment in its own attributed string so we can append it
    let image1String = NSAttributedString(attachment: image1Attachment)
    
    // add the NSTextAttachment wrapper to our full string, then add some more text.
    fullString.append(image1String)
    fullString.append(NSAttributedString(string: endWords))
    
    return fullString
  }
}
