//
//  ViewController.swift
//  Stopwatch
//
//  Created by Yi Gu on 2/18/16.
//  Copyright © 2016 YiGu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  var mainStopwatch: Stopwatch = Stopwatch()
  var lapStopwatch: Stopwatch = Stopwatch()
  var isPlay: Bool = false
  var laps: [String] = []
  
  @IBOutlet weak var timerLabel: UILabel!
  @IBOutlet weak var lapTimerLabel: UILabel!
  @IBOutlet weak var playPauseButton: UIButton!
  @IBOutlet weak var lapRestButton: UIButton!
  @IBOutlet weak var lapsTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initCircleButton(playPauseButton)
    initCircleButton(lapRestButton)
  
    
    lapRestButton.enabled = false
    
    lapsTableView.delegate = self;
    lapsTableView.dataSource = self;
  }
  
  func initCircleButton(button: UIButton) {
    button.layer.cornerRadius = 0.5 * button.bounds.size.width
    button.backgroundColor = UIColor.whiteColor()
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
      mainStopwatch.timer = NSTimer.scheduledTimerWithTimeInterval(0.035, target: self, selector: Selector("updateMainTimer"), userInfo: nil, repeats: true)
      lapStopwatch.timer = NSTimer.scheduledTimerWithTimeInterval(0.035, target: self, selector: Selector("updateLapTimer"), userInfo: nil, repeats: true)
      isPlay = true
      changeButton(playPauseButton, title: "Stop", titleColor: UIColor.redColor())
    } else {
      mainStopwatch.timer.invalidate()
      lapStopwatch.timer.invalidate()
      isPlay = false
      changeButton(playPauseButton, title: "Start", titleColor: UIColor.greenColor())
      changeButton(lapRestButton, title: "Reset", titleColor: UIColor.blackColor())
      
    }
  }
  
  @IBAction func lapResetTimer(sender: AnyObject) {
    if !isPlay {
      resetMainTimer()
      resetLapTimer()
      changeButton(lapRestButton, title: "Lap", titleColor: UIColor.lightGrayColor())
      lapRestButton.enabled = false
    } else {
      if let timerLabelText = timerLabel.text {
        laps.append(timerLabelText)
      }
      lapsTableView.reloadData()
      resetLapTimer()
      lapStopwatch.timer = NSTimer.scheduledTimerWithTimeInterval(0.035, target: self, selector: Selector("updateLapTimer"), userInfo: nil, repeats: true)
    }
  }
  
  func changeButton(button: UIButton, title: String, titleColor: UIColor) {
    button.setTitle(title, forState: UIControlState.Normal)
    button.setTitleColor(titleColor, forState: UIControlState.Normal)
  }
  
  // MARK: reset timer seperately
  func resetMainTimer() {
    resetTimer(mainStopwatch, label: timerLabel)
    laps.removeAll()
    lapsTableView.reloadData()
  }
  
  func resetLapTimer() {
    resetTimer(lapStopwatch, label: lapTimerLabel)
  }
  
  func resetTimer(stopwatch: Stopwatch, label: UILabel) {
    stopwatch.timer.invalidate()
    stopwatch.counter = 0.0
    label.text = "00:00:00"
  }
  
  // MARK: update two timer labels seperately
  func updateMainTimer() {
    updateTimer(mainStopwatch, label: timerLabel)
  }
  
  func updateLapTimer() {
    updateTimer(lapStopwatch, label: lapTimerLabel)
  }
  
  func updateTimer(stopwatch: Stopwatch, label: UILabel) {
    stopwatch.counter = stopwatch.counter + 0.035
    
    var minutes: String = "\((Int)(stopwatch.counter / 60))"
    if (Int)(stopwatch.counter / 60) < 10 {
      minutes = "0\((Int)(stopwatch.counter / 60))"
    }
    
    var seconds: String = String(format: "%.2f", (stopwatch.counter % 60))
    if stopwatch.counter % 60 < 10 {
      seconds = "0" + seconds
    }
    
    label.text = minutes + ":" + seconds
  }
  
  
  // MARK: tableView dataSource
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return laps.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let identifier: String = "lapCell"
    let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)

    if let labelNum = cell.viewWithTag(11) as? UILabel {
      labelNum.text = "Lap \(laps.count - indexPath.row)"
    }
    if let labelTimer = cell.viewWithTag(12) as? UILabel {
      labelTimer.text = laps[laps.count - indexPath.row - 1]
    }
    
    return cell
  }
  
}

