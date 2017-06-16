//
//  ViewController.swift
//  NotificationsUI
//
//  Copyright © 2016 Pranjal Satija. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func datePickerDidSelectNewDate(_ sender: UIDatePicker) {
      if let delegate = UIApplication.shared.delegate as? AppDelegate {
        delegate.scheduleNotification(at: sender.date)
      }
    }
}
