//
//  ViewController.swift
//  LoveTweet
//
//  Copyright © 2016 YiGu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var tweet: Tweet?
  
  // MARK: Outlets
  @IBOutlet weak var salaryLabel: UILabel!
  @IBOutlet weak var straightSwitch: UISwitch!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var workTextField: UITextField!
  @IBOutlet weak var birthdayPicker: UIDatePicker!
  @IBOutlet weak var genderSeg: UISegmentedControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    birthdayPicker.maximumDate = Date()
    
    // dismiss keyboard
    self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector.endEditing))
    
    nameTextField.delegate = self
    workTextField.delegate = self
  }
  
  @IBAction func salarySliderValueDidChange(_ sender: UISlider) {
    salaryLabel.text = "$\((Int)(sender.value))k"
  }
  
  @IBAction func tweetButtonDidTap(_ sender: UIButton) {
    func getLabelsInfo() -> (name: String?, work: String?, salary: String?) {
      guard let name = nameTextField.text,
        let work = workTextField.text,
        let salary = salaryLabel.text
        else {
          return (nil, nil, nil)
      }
      
      if name.isEmpty || work.isEmpty || salary.isEmpty {
        return (nil, nil, nil)
      }
      
      return (name, work, salary)
    }
    
    func getAge() -> Int? {
      let ageComponents = Calendar.current.dateComponents([.year], from: birthdayPicker.date, to: Date())
      return ageComponents.year
    }
    
    // get tweet info
    let labelsInfo = getLabelsInfo()
    
    if let name = labelsInfo.name, let work = labelsInfo.work, let salary = labelsInfo.salary, let age = getAge() {
      tweet = Tweet(gender: Gender(rawValue: genderSeg.selectedSegmentIndex)!, name: name, age: age, work: work, salary: salary, isStraight: straightSwitch.isOn)
    } else {
      tweet = nil
    }
    
    switch tweet {
    case .some(let tweet):
      showAlert(title: "Love Tweet",
                message: tweet.info,
                buttonTitle: "OK")
      
    case .none:
      showAlert(title: "Info miss or invalid",
                message: "Please fill out correct personal info",
                buttonTitle: "OK")
    }
  }
}

extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
