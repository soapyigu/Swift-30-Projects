//
//  ViewController.swift
//  LoveTweet
//
//  Copyright © 2016 YiGu. All rights reserved.
//

import UIKit
import Social

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
    self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    
    nameTextField.delegate = self
    workTextField.delegate = self
  }
  
  @IBAction func salarySliderValueDidChange(_ sender: UISlider) {
    salaryLabel.text = "$\((Int)(sender.value))k"
  }
  
  @IBAction func tweetButtonDidTap(_ sender: UIButton) {
    func getLabelsInfo() -> (String?, String?, String?) {
      guard let name = nameTextField.text,
        let work = workTextField.text,
        let salary = salaryLabel.text
        else {
          return (nil, nil, nil)
      }
      
      if name == "" || work == "" || salary == "" {
        return (nil, nil, nil)
      }
      
      return (name, work, salary)
    }
    
    func getAge() -> Int? {
      let ageComponents = Calendar.current.dateComponents([.year], from: birthdayPicker.date)
      return ageComponents.year
    }
    
    func getGenderInterest() -> String {
      if (genderSeg.selectedSegmentIndex == 0 && straightSwitch.isOn) {
        return "Women"
      } else if (genderSeg.selectedSegmentIndex == 1 && !straightSwitch.isOn) {
        return "Women"
      }
      
      return "Men"
    }
    
    let labelsInfo = getLabelsInfo()
    
    guard let name = labelsInfo.0, let work = labelsInfo.1, let salary = labelsInfo.2, let age = getAge() else {
      showAlert("Info miss or invalid", message: "Please fill out correct personal info", buttonTitle: "OK")
      return
    }
    
    let tweetMessenge = "Hi, I am \(name). As a \(age)-year-old \(work) earning \(salary)/year, I am interested in \(getGenderInterest()). Feel free to contact me!"
    
    tweet(messenge: tweetMessenge)
  }
  
  fileprivate func tweet(messenge m: String) {
    if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
      let twitterController: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
      twitterController.setInitialText(m)
      present(twitterController, animated: true, completion: nil)
    } else {
      showAlert("Twitter Unavailable", message: "Please configure your twitter account on device", buttonTitle: "Ok")
    }
  }
  
  fileprivate func showAlert(_ title: String, message: String, buttonTitle: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
}

extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
