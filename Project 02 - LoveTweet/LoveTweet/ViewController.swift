//
//  ViewController.swift
//  LoveTweet
//
//  Copyright © 2016 YiGu. All rights reserved.
//

import UIKit
import Social


class ViewController: UIViewController, UITextFieldDelegate {
  var tweet: String?
  
  // MARK: Outlets
  @IBOutlet weak var salaryLabel: UILabel!
  @IBOutlet weak var straightSwitch: UISwitch!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var workTextField: UITextField!
  @IBOutlet weak var birthdayPicker: UIDatePicker!
  @IBOutlet weak var genderSeg: UISegmentedControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
    self.view.addGestureRecognizer(tap)
    
  }
  
  @IBAction func salaryHandler(_ sender: AnyObject) {
    let slider = sender as! UISlider
    let i = Int(slider.value)
    salaryLabel.text = "$\(i)k"
  }
  
  @IBAction func tweetTapped(_ sender: AnyObject) {
    guard let name = nameTextField.text,
      let work = workTextField.text,
      let salary = salaryLabel.text
      else {
        return
    }
    
    if name == "" || work == "" || salary == "" {
      showAlert("Info Miss", message: "Please fill out the form", buttonTitle: "Ok")
    }
    
    // MARK: Get age
    let now = Date()
    let gregorian = Calendar(identifier: Calendar.Identifier.gregorian)
    let components = (gregorian as NSCalendar?)?.components(NSCalendar.Unit.year, from: birthdayPicker.date, to: now, options: [])
    let age: Int? = components?.year
    
    
    var interestedIn: String! = "Women"
    if (genderSeg.selectedSegmentIndex == 0 && !straightSwitch.isOn) {
      interestedIn = "Men"
    } else if (genderSeg.selectedSegmentIndex == 1 && straightSwitch.isOn ) {
      interestedIn = "Men"
    }
    
    let tweet = "Hi, I am \(name). As a \(age!)-year-old \(work) earning \(salary)/year, I am interested in \(interestedIn). Feel free to contact me!"
    
    tweetSLCVC(tweet)
  }
  
  fileprivate func tweetSLCVC(_ tweet: String) {
    if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
      let twitterController: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
      twitterController.setInitialText(tweet)
      self.present(twitterController, animated: true, completion: nil)
    } else {
      showAlert("Twitter Unavailable", message: "Please configure your twitter account on device", buttonTitle: "Ok")
    }
  }
  
  fileprivate func showAlert(_ title: String, message: String, buttonTitle: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    
    // MARK: Dismiss keyboard
    view.endEditing(true)
  }
    
    func animateTextField(textField: UITextField, up: Bool) {
        let movementDistance: CGFloat = -130
        let movementDuration: Double = 0.3
        
        var movement: CGFloat = 0
        if up {
            movement = movementDistance
        } else {
            movement = -movementDistance
        }
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateTextField(textField: textField, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.animateTextField(textField: textField, up: false)
    }
    
    

}

