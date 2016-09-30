//
//  ViewController.swift
//  LoveTweet
//
//  Created by Yi Gu on 2/15/16.
//  Copyright © 2016 YiGu. All rights reserved.
//

import UIKit
import Social

var tweet:String = ""

class ViewController: UIViewController {
  
  // MARK: Outlets
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var genderSeg: UISegmentedControl!
  @IBOutlet weak var birthdayPicker: UIDatePicker!
  @IBOutlet weak var workTextField: UITextField!
  @IBOutlet weak var salaryLabel: UILabel!
  @IBOutlet weak var straightSwitch: UISwitch!

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func salaryHandler(_ sender: AnyObject) {
    let slider = sender as! UISlider
    let i = Int(slider.value)
    salaryLabel.text = "$\(i)k"
  }
  

  @IBAction func tweetTapped(_ sender: AnyObject) {
    if (nameTextField.text == "" || workTextField.text == "" || salaryLabel.text == "") {
      showAlert("Info Miss", message: "Please fill out the form", buttonTitle: "Ok")
      return
    }
  
    let name:String! = nameTextField.text
    
    let work:String! = workTextField.text
    let salary:String! = salaryLabel.text
    
    // get age
    let gregorian = Calendar(identifier: Calendar.Identifier.gregorian)
    let now = Date()
    let components = (gregorian as NSCalendar?)?.components(NSCalendar.Unit.year, from: birthdayPicker.date, to: now, options: [])
    let age:Int! = components?.year
    
    var interestedIn:String! = "Women"
    if (genderSeg.selectedSegmentIndex == 0 && !straightSwitch.isOn) {
      interestedIn = "Men"
    }
    if (genderSeg.selectedSegmentIndex == 1 && straightSwitch.isOn ) {
      interestedIn = "Women"
    }
    
    let tweet = "Hi, I am \(name). As a \(age)-year-old \(work) earning \(salary)/year, I am interested in \(interestedIn). Feel free to contact me!"
    
    tweetSLCVC(tweet)
  }
  
  func tweetSLCVC(_ tweet: String) {
    if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter){
      let twitterController:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
      twitterController.setInitialText(tweet)
      self.present(twitterController, animated: true, completion: nil)
    } else {
      showAlert("Twitter Unavailable", message: "Please configure your twitter account on device", buttonTitle: "Ok")
    }
  }
  
  func showAlert(_ title:String, message:String, buttonTitle:String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}

