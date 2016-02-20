//
//  ViewController.swift
//  Stopwatch
//
//  Created by Yi Gu on 2/18/16.
//  Copyright © 2016 YiGu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var counter: Double = 0.00
  var timer: NSTimer = NSTimer()
  var isPlay: Bool = false
  var laps: [String] = []
  
  @IBOutlet weak var timerLabel: UILabel!
  @IBOutlet weak var playPauseButton: UIButton!
  @IBOutlet weak var lapRestButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initCircleButton(playPauseButton)
    initCircleButton(lapRestButton)
    
    lapRestButton.enabled = false
  }
  
  func initCircleButton(button: UIButton) {
    button.layer.cornerRadius = 0.5 * button.bounds.size.width
    button.backgroundColor = UIColor.whiteColor()
    button.layer.borderWidth = 1.0
    button.layer.borderColor = UIColor.blackColor().CGColor
  }
  
  // MARK: disable landscape mode
  override func shouldAutorotate() -> Bool {
    return false
  }
  
  override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.Portrait
  }
  
  // MARK: hide status bar
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
  
  // MARK: play, pause, lap, and reset
  @IBAction func playPauseTimer(sender: AnyObject) {
    lapRestButton.enabled = true
    changeButton(lapRestButton, title: "Lap", titleColor: UIColor.blackColor())
    if !isPlay {
      timer = NSTimer.scheduledTimerWithTimeInterval(0.035, target: self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
      isPlay = true
      changeButton(playPauseButton, title: "Stop", titleColor: UIColor.redColor())
    } else {
      timer.invalidate()
      isPlay = false
      changeButton(playPauseButton, title: "Start", titleColor: UIColor.greenColor())
      changeButton(lapRestButton, title: "Reset", titleColor: UIColor.blackColor())
      
    }
  }
  
  @IBAction func lapResetTimer(sender: AnyObject) {
    if !isPlay {
        reset()
        changeButton(lapRestButton, title: "Lap", titleColor: UIColor.lightGrayColor())
        lapRestButton.enabled = false
      } else {
        laps.append(timerLabel.text!)
      }
  }
  
  func changeButton(button: UIButton, title: String, titleColor: UIColor) {
    button.setTitle(title, forState: UIControlState.Normal)
    button.setTitleColor(titleColor, forState: UIControlState.Normal)
  }
  
  func reset() {
    timer.invalidate()
    counter = 0.00
    timerLabel.text = "00:00.00"
  }

  func updateTimer() {
    counter = counter + 0.035
    
    var minutes: String = "\((Int)(counter / 60))"
    if (Int)(counter / 60) < 10 {
      minutes = "0\((Int)(counter / 60))"
    }
    
    var seconds: String = "\(Double(round(100 * (counter % 60)) / 100))"
    if counter % 60 < 10 {
      seconds = "0" + seconds
    }
    
    timerLabel.text = minutes + ":" + seconds
  }
  
}

