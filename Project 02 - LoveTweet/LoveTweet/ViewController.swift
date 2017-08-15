//
//  ViewController.swift
//  LoveTweet
//
//  Copyright © 2016 YiGu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
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
      let ageComponents = Calendar.current.dateComponents([.year], from: birthdayPicker.date)
      return ageComponents.year
    }
    
    func getGenderInterest() -> String {
      if straightSwitch.isOn {
        switch genderSeg.selectedSegmentIndex {
        case Gender.Female.rawValue:
          return InterestedGender.MEN.rawValue
        case Gender.Male.rawValue:
          return InterestedGender.WOMEN.rawValue
        default:
          fatalError()
        }
      } else {
        switch genderSeg.selectedSegmentIndex {
        case Gender.Female.rawValue:
          return InterestedGender.WOMEN.rawValue
        case Gender.Male.rawValue:
          return InterestedGender.MEN.rawValue
        default:
          fatalError()
        }
      }
    }
    
    let labelsInfo = getLabelsInfo()
    
    guard let name = labelsInfo.name, let work = labelsInfo.work, let salary = labelsInfo.salary, let age = getAge() else {
      showAlert(title: "Info miss or invalid",
                       message: "Please fill out correct personal info",
                       buttonTitle: "OK")
      return
    }
    
    let tweetMessenge = "Hi, I am \(name). As a \(age)-year-old \(work) earning \(salary)/year, I am interested in \(getGenderInterest()). Feel free to contact me!"
    
    tweet(messenge: tweetMessenge)
  }
}

extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
