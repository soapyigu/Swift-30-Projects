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
  
  @IBAction func salaryHandler(sender: AnyObject) {
    let slider = sender as! UISlider
    let i = Int(slider.value)
    salaryLabel.text = "$\(i)k"
  }
  

  @IBAction func tweetTapped(sender: AnyObject) {
    if (nameTextField.text == "" || workTextField.text == "" || salaryLabel.text == "") {
      showAlert("Info Miss", message: "Please fill out the form", buttonTitle: "Ok")
      return
    }
  
    let name:String! = nameTextField.text
    
    let work:String! = workTextField.text
    let salary:String! = salaryLabel.text
    
    // get age
    let gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
    let now = NSDate()
    let components = gregorian?.components(NSCalendarUnit.Year, fromDate: birthdayPicker.date, toDate: now, options: [])
    let age:Int! = components?.year
    
    var interestedIn:String! = "Women"
    if (genderSeg.selectedSegmentIndex == 0 && !straightSwitch.on) {
      interestedIn = "Men"
    }
    if (genderSeg.selectedSegmentIndex == 1 && straightSwitch.on ) {
      interestedIn = "Women"
    }
    
    let tweet = "Hi, I am \(name). As a \(age)-year-old \(work) earning \(salary)/year, I am interested in \(interestedIn). Feel free to contact me!"
    
    tweetSLCVC(tweet)
  }
  
  func tweetSLCVC(tweet: String) {
    if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
      let twitterController:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
      twitterController.setInitialText(tweet)
      self.presentViewController(twitterController, animated: true, completion: nil)
    } else {
      showAlert("Twitter Unavailable", message: "Please configure your twitter account on device", buttonTitle: "Ok")
    }
  }
  
  func showAlert(title:String, message:String, buttonTitle:String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.Default, handler: nil))
    self.presentViewController(alert, animated: true, completion: nil)
  }
}

