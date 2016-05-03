//
//  ViewController.swift
//  Animations
//
//  Created by Yi Gu on 4/28/16.
//  Copyright © 2016 YiGu. All rights reserved.
//

import UIKit

let headerHeight = 50.0
let segueDetailIdentifier = "toAnimateDetail"

class ViewController: UIViewController {
  // MARK: - IBOutlets
  @IBOutlet weak var masterTableView: UITableView!
  
  // MARK: - Variables
  private let sections = ["BASIC ANIMATIONS", "KEYFRAME ANIMATIONS", "MULTIPLE ANIMATIONS"]
  private let items = [["2-Color", "Simple 2D Rotation"],
                       ["Multicolor", "Multi Point Position", "BezierCurve Position"],
                       ["Color and Frame Change"]]
  
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Segue
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == segueDetailIdentifier {
      let detailView = segue.destinationViewController as! DetailViewController
      let indexPath = masterTableView.indexPathForSelectedRow
      
      if let indexPath = indexPath {
        detailView.barTitle = self.items[indexPath.section][indexPath.row]
      }
    }
  }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return CGFloat(headerHeight)
  }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return self.sections.count
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.items[section].count
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return self.sections[section]
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cellIdentifier = "cell"
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
    
    cell.textLabel?.text = self.items[indexPath.section][indexPath.row]
    
    return cell
  }
}

