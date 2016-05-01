//
//  ViewController.swift
//  Animations
//
//  Created by Yi Gu on 4/28/16.
//  Copyright © 2016 YiGu. All rights reserved.
//

import UIKit

let headerHeight = 50.0

class ViewController: UIViewController {
  // MARK: - IBOutlets
  @IBOutlet weak var masterTableView: UITableView!
  
  private let sections = ["BASIC ANIMATIONS", "KEYFRAME ANIMATIONS", "MULTIPLE ANIMATIONS", "TRANSITIONS", "UIVIEW PROPERTY ANIMATIONS"]
  private let items = [["2-Color", "2-Point Position", "Simple 2D Rotation", "3D Rotation"],
                       ["Multicolor", "Multi Point Position", "BezierCurve Position"],
                       ["Color and Frame Change", "Color and Border(Apple)"],
                       ["Transitions"],
                       ["Simple Frame Change", "Multi Frame Change"]]
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
  
}

extension ViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return CGFloat(headerHeight)
  }
}

extension ViewController: UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return sections.count
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items[section].count
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sections[section]
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cellIdentifier = "cell"
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
    
    cell.textLabel?.text = items[indexPath.section][indexPath.row]
    
    return cell
  }
}

